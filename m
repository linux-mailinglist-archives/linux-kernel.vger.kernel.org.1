Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC82A0364
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgJ3Kyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:54:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgJ3Kyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:54:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 839C11F4509A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v3 02/16] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
 <20201026175526.2915399-3-enric.balletbo@collabora.com>
 <CANMq1KCe-QtQWXpmwFiCt4vcy0MG==L-C9cSU=o4W4OC5tyWgA@mail.gmail.com>
Message-ID: <c40054aa-212a-7e55-6437-4706e91bedaa@collabora.com>
Date:   Fri, 30 Oct 2020 11:54:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KCe-QtQWXpmwFiCt4vcy0MG==L-C9cSU=o4W4OC5tyWgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thank you for your comments.

On 27/10/20 1:55, Nicolas Boichat wrote:
> On Tue, Oct 27, 2020 at 1:55 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> The System Control Processor System (SCPSYS) has several power management
>> related tasks in the system. This driver implements support to handle
>> the different power domains supported in order to meet high performance
>> and low power requirements.
>>
>> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Return only a boolean for scpsys_domain_is_on()
>> - Use regmap_update_bits API when possible.
>> - Add some logic to make sure scpsys->domains[id] == NULL or != NULL
>>   when needed.
>> - Return the child node for scpsys_add_one_domain() call.
>> - Remove unneded zeroing num_clks variable.
>> - Move the soc specific data to separate include files.
>>
>> Changes in v2:
>> - Get base address from parent syscon. We have now a scpsys syscon node
>>   and a child for the SPM (System Power Manager).
>> - Use regmap API to acces de base address.
>>
>>  drivers/soc/mediatek/Kconfig             |  13 +
>>  drivers/soc/mediatek/Makefile            |   1 +
>>  drivers/soc/mediatek/mt8173-pm-domains.h |  96 +++++
>>  drivers/soc/mediatek/mtk-pm-domains.c    | 455 +++++++++++++++++++++++
>>  drivers/soc/mediatek/mtk-pm-domains.h    |  65 ++++
>>  5 files changed, 630 insertions(+)
>>  create mode 100644 drivers/soc/mediatek/mt8173-pm-domains.h
>>  create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
>>  create mode 100644 drivers/soc/mediatek/mtk-pm-domains.h
> [snip]
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>> new file mode 100644
>> index 000000000000..16503d6db6a8
>> --- /dev/null
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>> @@ -0,0 +1,455 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2020 Collabora Ltd.
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_clk.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/regmap.h>
>> +#include <linux/soc/mediatek/infracfg.h>
>> +
>> +#include "mt8173-pm-domains.h"
>> +
>> +#define MTK_POLL_DELAY_US              10
>> +#define MTK_POLL_TIMEOUT               USEC_PER_SEC
>> +
>> +#define PWR_RST_B_BIT                  BIT(0)
>> +#define PWR_ISO_BIT                    BIT(1)
>> +#define PWR_ON_BIT                     BIT(2)
>> +#define PWR_ON_2ND_BIT                 BIT(3)
>> +#define PWR_CLK_DIS_BIT                        BIT(4)
>> +
>> +struct scpsys_domain {
>> +       struct generic_pm_domain genpd;
>> +       const struct scpsys_domain_data *data;
>> +       struct scpsys *scpsys;
>> +       int num_clks;
>> +       struct clk_bulk_data *clks;
>> +       struct regmap *infracfg;
>> +};
>> +
>> +struct scpsys {
>> +       struct device *dev;
>> +       struct regmap *base;
>> +       const struct scpsys_soc_data *soc_data;
>> +       struct genpd_onecell_data pd_data;
>> +       struct generic_pm_domain *domains[];
>> +};
>> +
>> +#define to_scpsys_domain(gpd) container_of(gpd, struct scpsys_domain, genpd)
>> +
>> +static int scpsys_domain_is_on(struct scpsys_domain *pd)
> 
> static bool?
> 

Done in next version.

>> +{
>> +       struct scpsys *scpsys = pd->scpsys;
>> +       u32 status, status2;
>> +
>> +       regmap_read(scpsys->base, scpsys->soc_data->pwr_sta_offs, &status);
>> +       status &= pd->data->sta_mask;
>> +
>> +       regmap_read(scpsys->base, scpsys->soc_data->pwr_sta2nd_offs, &status2);
>> +       status2 &= pd->data->sta_mask;
>> +
>> +       /* A domain is on when both status bits are set. */
>> +       return status && status2;
>> +}
>> +
>> +static int scpsys_sram_enable(struct scpsys_domain *pd)
>> +{
>> +       u32 pdn_ack = pd->data->sram_pdn_ack_bits;
>> +       struct scpsys *scpsys = pd->scpsys;
>> +       unsigned int tmp;
>> +
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits, 0);
>> +
>> +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
>> +       return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
>> +                                       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>> +}
>> +
>> +static int scpsys_sram_disable(struct scpsys_domain *pd)
>> +{
>> +       u32 pdn_ack = pd->data->sram_pdn_ack_bits;
>> +       struct scpsys *scpsys = pd->scpsys;
>> +       unsigned int tmp;
>> +
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits,
>> +                          pd->data->sram_pdn_bits);
>> +
>> +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
>> +       return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
>> +                                       (tmp & pdn_ack) == pdn_ack, MTK_POLL_DELAY_US,
>> +                                       MTK_POLL_TIMEOUT);
>> +}
>> +
>> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>> +{
>> +       const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
>> +
>> +       if (!bp_data->bus_prot_mask)
>> +               return 0;
>> +
>> +       return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
>> +                                              bp_data->bus_prot_reg_update);
>> +}
>> +
>> +static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>> +{
>> +       const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
>> +
>> +       if (!bp_data->bus_prot_mask)
>> +               return 0;
>> +
>> +       return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
>> +                                                bp_data->bus_prot_reg_update);
>> +}
>> +
>> +static int scpsys_power_on(struct generic_pm_domain *genpd)
>> +{
>> +       struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
>> +       struct scpsys *scpsys = pd->scpsys;
>> +       unsigned int tmp;
> 
> bool tmp?
> 

Ack

>> +       int ret;
>> +
>> +       ret = clk_bulk_enable(pd->num_clks, pd->clks);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* subsys power on */
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT, PWR_ON_BIT);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT, PWR_ON_2ND_BIT);
>> +
>> +       /* wait until PWR_ACK = 1 */
>> +       ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp > 0, MTK_POLL_DELAY_US,
> 
> `tmp > 0` is a little weird now that scpsys_domain_is_on returns a
> boolean. Just use `tmp`.
> 

Right, done in next version

>> +                                MTK_POLL_TIMEOUT);
>> +       if (ret < 0)
>> +               goto err_pwr_ack;
>> +
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT, 0);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT, 0);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT, PWR_RST_B_BIT);
>> +
>> +       ret = scpsys_sram_enable(pd);
>> +       if (ret < 0)
>> +               goto err_pwr_ack;
>> +
>> +       ret = scpsys_bus_protect_disable(pd);
>> +       if (ret < 0)
>> +               goto err_pwr_ack;
> 
> Do we need to disable the SRAM in this error path?
> 

Yes, added in next version.

>> +
>> +       return 0;
>> +
>> +err_pwr_ack:
>> +       clk_bulk_disable(pd->num_clks, pd->clks);
>> +       return ret;
>> +}
>> +
>> +static int scpsys_power_off(struct generic_pm_domain *genpd)
>> +{
>> +       struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
>> +       struct scpsys *scpsys = pd->scpsys;
>> +       unsigned int tmp;
>> +       int ret;
>> +
>> +       ret = scpsys_bus_protect_enable(pd);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = scpsys_sram_disable(pd);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* subsys power off */
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT, 0);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT, PWR_ISO_BIT);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT, PWR_CLK_DIS_BIT);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT, 0);
>> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT, 0);
>> +
>> +       /* wait until PWR_ACK = 0 */
>> +       ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp == 0, MTK_POLL_DELAY_US,
> 
> `!tmp` as condition.
> 

Ack

>> +                                MTK_POLL_TIMEOUT);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       clk_bulk_disable(pd->num_clks, pd->clks);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct
>> +generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
>> +{
>> +       const struct scpsys_domain_data *domain_data;
>> +       struct scpsys_domain *pd;
>> +       int i, ret;
>> +       u32 id;
>> +
>> +       ret = of_property_read_u32(node, "reg", &id);
>> +       if (ret) {
>> +               dev_err(scpsys->dev, "%pOF: failed to retrieve domain id from reg: %d\n",
>> +                       node, ret);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       if (id >= scpsys->soc_data->num_domains) {
>> +               dev_err(scpsys->dev, "%pOF: invalid domain id %d\n", node, id);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       domain_data = &scpsys->soc_data->domains[id];
> 
> See my comment on v2. domain_data = scpsys->soc_data->domains[id]; is
> probably what you want (unless I got it completely wrong...)
> 

Answered there :-). I think the purpose of the check is still valid, but, yes,
checking now if sta_mask mask is set. Thank you!

>> +       if (!domain_data) {
>> +               dev_err(scpsys->dev, "%pOF: undefined domain id %d\n", node, id);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
>> +       if (!pd)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       pd->data = domain_data;
>> +       pd->scpsys = scpsys;
>> +
>> +       pd->infracfg = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
>> +       if (IS_ERR(pd->infracfg))
>> +               pd->infracfg = NULL;
>> +
>> +       pd->num_clks = of_clk_get_parent_count(node);
>> +       if (pd->num_clks > 0) {
>> +               pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
>> +               if (!pd->clks)
>> +                       return ERR_PTR(-ENOMEM);
>> +       }
> [snip]
> 
