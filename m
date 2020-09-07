Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0F25FA05
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 13:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgIGL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 07:59:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40106 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgIGL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:56:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087Bu5ci017876;
        Mon, 7 Sep 2020 06:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599479765;
        bh=lzHjznokUt6NguFzb3Y0QgPfGqsxuA+KrLarJ2ybN70=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AbQ6Zi81uMB6BA/FMnK4M0rhWVAgv6QnTRVWhrB+RQFCy0/F8G/OjJtlzskpdhgbq
         csIVp4/6RRMdO5ryMwizwHcIcays9Yk76TZL9GQcqwAyHr0JdOorpokeWiiU/l0cqY
         mIfy6KakcOykzNo8p9mw7dWQqR3N8FMP1ZejK/60=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087Bu5T6092196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 06:56:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 06:56:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 06:56:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087Bu5ak083227;
        Mon, 7 Sep 2020 06:56:05 -0500
Date:   Mon, 7 Sep 2020 06:56:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: allow frequency change for disabled
 clocks by default
Message-ID: <20200907115605.j3w5cgdscpxqrzl2@akan>
References: <20200907110357.2972-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907110357.2972-1-t-kristo@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:03-20200907, Tero Kristo wrote:
> If a clock is disabled, its frequency should be allowed to change as
> it is no longer in use. Add a flag towards this to the firmware clock
> API handler routines.
> 
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 53cee17d0115..39890665a975 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1124,7 +1124,8 @@ static int ti_sci_cmd_get_clock(const struct ti_sci_handle *handle, u32 dev_id,
>  static int ti_sci_cmd_idle_clock(const struct ti_sci_handle *handle,
>  				 u32 dev_id, u32 clk_id)
>  {
> -	return ti_sci_set_clock_state(handle, dev_id, clk_id, 0,
> +	return ti_sci_set_clock_state(handle, dev_id, clk_id,
> +				      MSG_FLAG_CLOCK_ALLOW_FREQ_CHANGE,
>  				      MSG_CLOCK_SW_STATE_UNREQ);
>  }
>  
> @@ -1143,7 +1144,8 @@ static int ti_sci_cmd_idle_clock(const struct ti_sci_handle *handle,
>  static int ti_sci_cmd_put_clock(const struct ti_sci_handle *handle,
>  				u32 dev_id, u32 clk_id)
>  {
> -	return ti_sci_set_clock_state(handle, dev_id, clk_id, 0,
> +	return ti_sci_set_clock_state(handle, dev_id, clk_id,
> +				      MSG_FLAG_CLOCK_ALLOW_FREQ_CHANGE,
>  				      MSG_CLOCK_SW_STATE_AUTO);
>  }
>  

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
