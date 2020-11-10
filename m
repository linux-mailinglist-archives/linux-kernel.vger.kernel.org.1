Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70CD2ADB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgKJQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:01:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06153C0613CF;
        Tue, 10 Nov 2020 08:01:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DADA91F44B95
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Set partner
 num_altmodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20201110061535.2163599-1-pmalani@chromium.org>
 <20201110061535.2163599-2-pmalani@chromium.org>
 <20201110105015.GF1224435@kuha.fi.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ba6c1415-457b-1e8d-b604-fad603fe9be6@collabora.com>
Date:   Tue, 10 Nov 2020 17:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110105015.GF1224435@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/11/20 11:50, Heikki Krogerus wrote:
> On Mon, Nov 09, 2020 at 10:15:36PM -0800, Prashant Malani wrote:
>> Set the number of altmodes available for a registered partner using the
>> Type C connector class framework routine.
>>
>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Heikki, would you like to take these two through your tree? It'd help if you can
create an inmutable branch so I can pick other cros_ec_typec patches on top of it.

Thanks,
 Enric

>> ---
>>
>> Changes in v2:
>> - Patch introduced for the first time in v2.
>>
>>  drivers/platform/chrome/cros_ec_typec.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>> index ce031a10eb1b..743a28426f98 100644
>> --- a/drivers/platform/chrome/cros_ec_typec.c
>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>> @@ -621,6 +621,7 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>>  	struct cros_typec_altmode_node *node;
>>  	struct typec_altmode_desc desc;
>>  	struct typec_altmode *amode;
>> +	int num_altmodes = 0;
>>  	int ret = 0;
>>  	int i, j;
>>  
>> @@ -647,9 +648,16 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>>  
>>  			node->amode = amode;
>>  			list_add_tail(&node->list, &port->partner_mode_list);
>> +			num_altmodes++;
>>  		}
>>  	}
>>  
>> +	ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
>> +	if (ret < 0) {
>> +		dev_err(typec->dev, "Unable to set partner num_altmodes for port: %d\n", port_num);
>> +		goto err_cleanup;
>> +	}
>> +
>>  	return 0;
>>  
>>  err_cleanup:
>> -- 
>> 2.29.2.222.g5d2a92d10f8-goog
> 
> thanks,
> 
