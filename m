Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDE2C6639
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgK0NB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:01:58 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58205 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729792AbgK0NB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:01:58 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCQX1b022358;
        Fri, 27 Nov 2020 14:01:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=N9+yqyObC4up1jt4XVcmEQWQQISeDtGWU+BIy3jtqu4=;
 b=zoxrkddKbab7uztzquM21tapUo3ZL28jqu7pih0TCHxr5eGZj3+LCN3KpIweHz8R3CMF
 ReBOENVSfQhMz5Tgtlg++Tariiv1ID58KTQz2SqDKwXJEC8iRuVftI8z2pcGXFyRCkyV
 eDZDWe/fbF7cHe+6FKRdiH+hakv+pDo/aZJvB1CuX1e6MwG8zh0gsPOCAKEHx4PrI5gD
 f2L6875o4nwtvi9Y4/NeXvT9cNJyFRzjJIDCTR7DMLbTqSfD8XD3u7wKmuw/pqWofviB
 rudkqImx22SFhiLQp9bPG8lt4rmzSGOWSdu1WJES4vMYXqCISqK0mpsI0CuMtqZpLJmr cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y05htp9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:01:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5AD1C10002A;
        Fri, 27 Nov 2020 14:01:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 310D1247D1E;
        Fri, 27 Nov 2020 14:01:32 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 14:01:30 +0100
Subject: Re: [PATCH v5 3/5] usb: typec: stusb160x: fix power-opmode property
 with typec-power-opmode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-4-amelie.delaunay@st.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <e97a537a-9c7e-cd98-8ffa-93abae087128@st.com>
Date:   Fri, 27 Nov 2020 14:01:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106165805.31534-4-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gentle reminder for this patch, lost in the middle of a DT series (DT 
part already in stm32-next).

Thanks and regards,
Amelie

On 11/6/20 5:58 PM, Amelie Delaunay wrote:
> Device tree property is named typec-power-opmode, not power-opmode.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/stusb160x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index 2a618f02f4f1..d21750bbbb44 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -562,7 +562,7 @@ static int stusb160x_get_fw_caps(struct stusb160x *chip,
>   	 * Supported power operation mode can be configured through device tree
>   	 * else it is read from chip registers in stusb160x_get_caps.
>   	 */
> -	ret = fwnode_property_read_string(fwnode, "power-opmode", &cap_str);
> +	ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &cap_str);
>   	if (!ret) {
>   		ret = typec_find_pwr_opmode(cap_str);
>   		/* Power delivery not yet supported */
> 
