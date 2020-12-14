Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252742DA0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502945AbgLNUCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:02:09 -0500
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:55738
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502757AbgLNUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:01:46 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1kou1j-000527-5S
        for linux-kernel@vger.kernel.org; Mon, 14 Dec 2020 21:00:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] net: mscc: ocelot: Fix a resource leak in the error
 handling path of the probe function
Date:   Mon, 14 Dec 2020 21:00:53 +0100
Message-ID: <ecca5770-7cb3-c0a0-0a33-fcc3854d0b74@wanadoo.fr>
References: <20201213114838.126922-1-christophe.jaillet@wanadoo.fr>
 <20201214114831.GE2809@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201214114831.GE2809@kadam>
Content-Language: en-US
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/12/2020 à 12:48, Dan Carpenter a écrit :
> On Sun, Dec 13, 2020 at 12:48:38PM +0100, Christophe JAILLET wrote:
>> In case of error after calling 'ocelot_init()', it must be undone by a
>> corresponding 'ocelot_deinit()' call, as already done in the remove
>> function.
>>
> 
> This changes the behavior slightly in another way as well, but it's
> probably a bug fix.
> 
> drivers/net/ethernet/mscc/ocelot_vsc7514.c
>    1250          ports = of_get_child_by_name(np, "ethernet-ports");
>    1251          if (!ports) {
>    1252                  dev_err(ocelot->dev, "no ethernet-ports child node found\n");
>    1253                  return -ENODEV;
>    1254          }
>    1255
>    1256          ocelot->num_phys_ports = of_get_child_count(ports);
>    1257          ocelot->num_flooding_pgids = 1;
>    1258
>    1259          ocelot->vcap = vsc7514_vcap_props;
>    1260          ocelot->inj_prefix = OCELOT_TAG_PREFIX_NONE;
>    1261          ocelot->xtr_prefix = OCELOT_TAG_PREFIX_NONE;
>    1262          ocelot->npi = -1;
>    1263
>    1264          err = ocelot_init(ocelot);
>    1265          if (err)
>    1266                  goto out_put_ports;
>    1267
>    1268          err = mscc_ocelot_init_ports(pdev, ports);
>    1269          if (err)
>    1270                  goto out_put_ports;
>    1271
>    1272          if (ocelot->ptp) {
>    1273                  err = ocelot_init_timestamp(ocelot, &ocelot_ptp_clock_info);
>    1274                  if (err) {
>    1275                          dev_err(ocelot->dev,
>    1276                                  "Timestamp initialization failed\n");
>    1277                          ocelot->ptp = 0;
>    1278                  }
> 
> In the original code, if ocelot_init_timestamp() failed we returned
> a negative error code but now we return success.  This probably is what
> the original authors intended, though.
> 

Thanks for the detailed review Dan.

I agree with you. However this "fix" was not intentional. :(

This may worth stating it in the commit message.
Can it be done when/if the patch is applied?

CJ

