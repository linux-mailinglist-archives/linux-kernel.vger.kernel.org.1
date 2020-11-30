Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215BD2C7C70
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgK3Bdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbgK3Bdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:33:40 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DCC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 17:33:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so9527819qkc.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 17:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79ZPDI9jet3qQx0nLGLby/X6fEkmogOcX+WawS/Znx8=;
        b=iVHdx6XcF5BeoqhxM6ZxHHjQxN7AMUe1/MLu1ZM5rWbXU2cE/ZODR+8I7SH4FqG5/M
         ORE5nQrHihBO6xVwN1N4JXOAwevKvOD/Z8k1eiCAbH99Yz9fTyzg0UUpZFONg01SkN39
         VlxniP8OnVeCeDcZnXoFCJzCIl0UqTMS/3nrlzu+zE6jPj0U8FKEZxFYfwCid/RA72vh
         zBwhgfz/v7ynB3rb31jsj7esBMPscNNkyTi35M7yFEa8B88TOh6ItLERyQ7kq3xEGIKV
         u6jBCL8YBFxIkSRTW6Db8S2beUA/24zBXz5MIjwavIidcGo5YAWUH7ZprV+q1SctTZj6
         DQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79ZPDI9jet3qQx0nLGLby/X6fEkmogOcX+WawS/Znx8=;
        b=ZagS3jWJZAMGH+xLQghw8UzH1KfXeHrxgi0qzKgKYgfyTgjzKbKsJZMYmMWiCW7Pvf
         tj7EAIy7zFsOGJq97zu2qmQbDeM1g0KEb7UU+YPYeTAyUgrscqHqZvVT5xkBjig43982
         hip0PQZ0UupsDrAT92l1QNaU6f7NguC1DfTSKPCSdrjSaRo47AzqooShNS1B4C9h2eM0
         A016NYy5NJKpb9dFXc41kYdl9QuJxsxRiJd8hTAX3cPUFF2HETyAD008MM5kPCotNfit
         q4coFsZcVpJZtYYpM80Qfqf6Hy54QdppN9f0YRDVqykAs9pqlgU+hNyDBE43yMD4UZX2
         A/Ng==
X-Gm-Message-State: AOAM530d5IBQ/aYuUV+pwGMnD4d+b208l3nNpV5/uuqKCk/z6EUwkinQ
        ScF2KW9u9OVjpclMsbVUnQ==
X-Google-Smtp-Source: ABdhPJxdVcjRAk8wbCP6AkFKa1PnFTXgfj267PSq37MK2njQoF7O1cHAQehTLkg84BOEDKgaeZHOxA==
X-Received: by 2002:ae9:eb10:: with SMTP id b16mr21139219qkg.494.1606699979414;
        Sun, 29 Nov 2020 17:32:59 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id s12sm13852161qtq.60.2020.11.29.17.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Nov 2020 17:32:58 -0800 (PST)
Date:   Sun, 29 Nov 2020 20:32:56 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        m.mizuma@jp.fujitsu.com
Subject: Re: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
Message-ID: <20201130013256.oryyz4wxd356n74o@gabell>
References: <20201121021243.1532477-1-libo.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121021243.1532477-1-libo.chen@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:12:43PM -0800, Libo Chen wrote:
> This issue was first noticed when I was testing different kernels on
> Oracle Linux 8 which as Fedora 30+ adopts BLS as default. Even though a
> kernel entry was added successfully and the index of that kernel entry was
> retrieved correctly, ktest still wouldn't reboot the system into
> user-specified kernel.
> 
> The bug was spotted in subroutine reboot_to where the if-statement never
> checks for REBOOT_TYPE "grub2bls", therefore the desired entry will not be
> set for the next boot.
> 
> Add a check for "grub2bls" so that $grub_reboot $grub_number can
> be run before a reboot if REBOOT_TYPE is "grub2bls" then we can boot to
> the correct kernel.
> 
> Fixes: ac2466456eaa ("ktest: introduce grub2bls REBOOT_TYPE option")
> 
> Signed-off-by: Libo Chen <libo.chen@oracle.com>

Thank you for the fix!
I tested the patch with fedora33. It works well.

Please feel free to add:

	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa

> ---
>  tools/testing/ktest/ktest.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index cb16d2aac51c..54188ee16c48 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -2040,7 +2040,7 @@ sub reboot_to {
>  
>      if ($reboot_type eq "grub") {
>  	run_ssh "'(echo \"savedefault --default=$grub_number --once\" | grub --batch)'";
> -    } elsif ($reboot_type eq "grub2") {
> +    } elsif (($reboot_type eq "grub2") or ($reboot_type eq "grub2bls")) {
>  	run_ssh "$grub_reboot $grub_number";
>      } elsif ($reboot_type eq "syslinux") {
>  	run_ssh "$syslinux --once \\\"$syslinux_label\\\" $syslinux_path";
> -- 
> 2.27.0
> 
