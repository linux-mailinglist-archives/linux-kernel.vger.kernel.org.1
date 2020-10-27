Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394D329BBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1809629AbgJ0Q1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:27:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1808956AbgJ0QZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:25:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 75B331F453F0
Subject: Re: [PATCH v2 02/12] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-3-enric.balletbo@collabora.com>
 <CANMq1KDSsfX3r1440qbmWggqbD7pU_iM4S36LUF8rsS2jVGqOg@mail.gmail.com>
 <ebba9def-e394-c183-dd80-6dc3716a7bd1@collabora.com>
 <CANMq1KBfKK9-RfMK89hRCGzhqZVqs6+YRdw8o2K+jA+3VN1_gw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2e6def0a-400c-836f-ef8b-c4fe6ac6c26e@collabora.com>
Date:   Tue, 27 Oct 2020 17:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KBfKK9-RfMK89hRCGzhqZVqs6+YRdw8o2K+jA+3VN1_gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 27/10/20 1:19, Nicolas Boichat wrote:
> Hi Enric,
> 
> On Mon, Oct 26, 2020 at 11:17 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Nicolas,
>>
>> Many thanks for looking at this.
> 
> Thanks to you ,-)
> 
> [snip]
>>>> +       if (id >= scpsys->soc_data->num_domains) {
>>>> +               dev_err_probe(scpsys->dev, -EINVAL, "%pOFn: invalid domain id %d\n", node, id);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       domain_data = &scpsys->soc_data->domains[id];
>>>> +       if (!domain_data) {
>>>
>>> Is that even possible at all? I mean, even if
>>> scpsys->soc_data->domains is NULL, as long as id != 0, this will no
>>> happen.
>>>
>>
>> I think could happen with a bad DT definition. I.e if for the definition of the
>> MT8173 domains you use a wrong value for the reg property, a value that is not
>> present in the SoC data. It is unlikely if you use the defines but could happen
>> if you hardcore the value. We cannot check this with the DT json-schema.
> 
> I wasn't clear in my explanation, and looking further there is more
> that looks wrong.
> 
> This expression &scpsys->soc_data->domains[id] is a pointer to element
> "id" of the array domains. So if you convert to integer arithmetic,
> it'll be something like `(long)scpsys->soc_data->domains +
> (sizeof(struct generic_pm_domain *)) * id`. The only way this can be
> NULL is if scpsys->soc_data->domains pointer is NULL, which, actually,
> can't really happen as it's the 5th element of a struct scpsys
> structure `(long)scpsys->soc_data + offset_of(domains, struct scpsys)
> + (sizeof(struct generic_pm_domain *)) * id`.
> 
> I think what you mean is either:
> domain_data = &scpsys->soc_data->domains[id];
> if (!*domain_data)
> [but then domain_data type should be `struct generic_pm_domain **`?

I think you're confusing the field `struct generic_pm_domain *domains[]`from the
`struct scpsys` with `const struct scpsys_domain_data *domains` from `struct
scpsys_soc_data`. My bad they have the same name, I should probably rename the
second one as domain_info or domain_data to avoid that confusion.


diff --git a/drivers/soc/mediatek/mtk-pm-domains.h
b/drivers/soc/mediatek/mtk-pm-domains.h
index 7c8efcb3cef2..6ff095db8a27 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -56,7 +56,7 @@ struct scpsys_domain_data {
 };

 struct scpsys_soc_data {
-       const struct scpsys_domain_data *domains;
+       const struct scpsys_domain_data *domain_data;
        int num_domains;
        int pwr_sta_offs;
        int pwr_sta2nd_offs;

---

struct scpsys {
    ...
    const struct scpsys_soc_data *soc_data;
    ...
    struct generic_pm_domain *domains[];
}


domain_data = &scpsys->soc_data->domain_data[id];
if (!domain_data)

Thanks,
  Enric


> Does your code compile with warnings enabled?]
> or:
> domain_data = scpsys->soc_data->domains[id];
> if (!domain_data)
> [then the test makes sense]
> 
> [snip]
> 
