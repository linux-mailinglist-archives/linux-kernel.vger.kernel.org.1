Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D091294524
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 00:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439058AbgJTW3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 18:29:17 -0400
Received: from lithium.sammserver.com ([168.119.122.30]:33762 "EHLO
        lithium.sammserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392454AbgJTW3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:29:16 -0400
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 54DDE312B5A9;
        Wed, 21 Oct 2020 00:29:15 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 07EB61131C4F; Wed, 21 Oct 2020 00:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1603232955; bh=ReitwSbZ/fEJxIhaeb16wIu56zn2EFv30T8ySvSFH0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfhnUco5osuGZc32XXNMB5dvr+eQJWCyJPhgYcDi0GhEpkJDMy9sq8Bq3ZSMIs6/N
         Np5j+X/juEh7J8xYH3fT7uQ2OmWN+3I0SGn6gsF6p7g9pTFX480G5oSvpO5L+unmfp
         clbyixbMjyufHyeSUqHah6qfzhuY6LopQ1hzsSe4=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id DBF521131C4C;
        Wed, 21 Oct 2020 00:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1603232955; bh=ReitwSbZ/fEJxIhaeb16wIu56zn2EFv30T8ySvSFH0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfhnUco5osuGZc32XXNMB5dvr+eQJWCyJPhgYcDi0GhEpkJDMy9sq8Bq3ZSMIs6/N
         Np5j+X/juEh7J8xYH3fT7uQ2OmWN+3I0SGn6gsF6p7g9pTFX480G5oSvpO5L+unmfp
         clbyixbMjyufHyeSUqHah6qfzhuY6LopQ1hzsSe4=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id C3CB714209CF; Wed, 21 Oct 2020 00:29:14 +0200 (CEST)
Date:   Wed, 21 Oct 2020 00:29:14 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: asus-wmi: Add support for
 SW_TABLET_MODE on UX360
Message-ID: <20201020222914.6k2pkxiirzbefjml@fastboi.localdomain>
References: <20201020220944.1075530-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020220944.1075530-1-samuel@cavoj.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS autolearn=no autolearn_force=no
        version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on sammserver.tu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

naturally I notice this right after I send the patch, but my whitespace
is wrong. Time to set a pre-commit hook up. I guess that means a v4,
unless you would fix it on your end? It's just a single line.

Sorry about all the noise,
Sam

On 21.10.2020 00:09, Samuel Čavoj wrote:
> @@ -375,6 +376,20 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>  		}
>  	}
>  
> +	if (asus->driver->quirks->use_lid_flip_devid) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +        if (result < 0)

Right ^here.

> +			asus->driver->quirks->use_lid_flip_devid = 0;
> +		if (result >= 0) {
> +			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +		} else if (result == -ENODEV) {
> +			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
> +		} else {
> +			pr_err("Error checking for lid-flip: %d\n", result);
> +		}
> +	}
