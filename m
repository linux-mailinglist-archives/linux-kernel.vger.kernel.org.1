Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C10292381
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgJSITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 04:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbgJSITh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:19:37 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA872225F;
        Mon, 19 Oct 2020 08:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603095576;
        bh=1Z6GkNNCLc/Ru7IMkiC0ql5jezqPmhpjXzrpxYKJbbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwHnfMEG4pCtPEAYIRIhQuQzztVUyjcdpf7gs+irKqKYuMNVNxD2ZRlrhByawlaRG
         K6OPtMMHM3RrrrFlbBK6YtCBFn7rOixdNqs+m+4WseSR5hOHYHHVoq8vzmMBvNp8BK
         ZsF8GthSHimfAjP94KwmuOwxSYEtkRWLn667gk7c=
Received: by pali.im (Postfix)
        id 14817B70; Mon, 19 Oct 2020 10:19:34 +0200 (CEST)
Date:   Mon, 19 Oct 2020 10:19:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: marvell: espressobin: Update link to V7
 schematic
Message-ID: <20201019081933.32w6flugk55n2i4q@pali>
References: <20200925084306.16309-1-pali@kernel.org>
 <20201005133513.8649-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005133513.8649-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory, it is OK now?

On Monday 05 October 2020 15:35:13 Pali Rohár wrote:
> Up-to-date version of V7 schematic is on new URL linked from official
> tech-spec webpage http://espressobin.net/tech-spec/
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in V2:
> * Added commit description
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index e225dce64b9e..4775a7eda481 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -8,7 +8,7 @@
>   *
>   */
>  /*
> - * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> + * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 44dbe9a21cc7..c47a93978386 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -8,7 +8,7 @@
>   *
>   */
>  /*
> - * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> + * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
>   */
>  
>  /dts-v1/;
> -- 
> 2.20.1
> 
