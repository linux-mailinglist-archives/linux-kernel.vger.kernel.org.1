Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155B52FA136
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbhARNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404400AbhARNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:19:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8251C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:18:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 6so9142661wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dT8H6DDOS90XqFHWCI7TqFyOQmYmAu8E1f2CVSOpl/o=;
        b=EgspKE8oFCLCiFmdwKtBz2VjUuROfWzgFVAWJT2v2444A0T/mq8eQwih4wjcbDddGB
         kXj2hnBpS3W4vDilb//9GY6jrkUfIj44PxVpxH9MYX5ds+1WnMVw4MzIhG9J0reDPisi
         scE5mTvdAw5Hlnnn4IAsMJw8kncej6tCC3sqbl6YcHhuoYyKStMyGTHZ33dug43+iaLi
         /vLjOyriHbV/JZgpR6REiio1aSN9n5pXnhww3etjfo01vaa34iINw6EeAMAFbx+NYhgA
         rmoDjcd5wEqNg07GM1PnTNgJTYdRNnZMMnL9gFv1EMrC7g5IwYhcj+CIV849advE4KO/
         cG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dT8H6DDOS90XqFHWCI7TqFyOQmYmAu8E1f2CVSOpl/o=;
        b=hiB7gb7oevynojDvIlJW1rr3dGpadx+n+Co3OYLZujptbcRB21eQDEwaVQMPftX/Z1
         Ck4kJL9sRYk52Coy5wfALFAx11zmDLDGyAYbAGxa52tc2VjlsbwjAVcov9WLAqccC98W
         URZ8xkcnN/oo/KB5UW9nf0dQddT2PpkgSCKaQQVNULFp1g8G1C9TyIR9/5oVtbz8LPCq
         /PDYVlVxMfHzpuNjZ+ytC43AXpNYA5snk06QzbHurr9i21H64TY6olhxenHvbRKShPIZ
         /kZ0q952yBK+nU3bTfFX4KEWhYJP0zY0Eor3ZFa8gRbh4FLyKDPLVEOkv5vQNt6dc8G+
         LCcw==
X-Gm-Message-State: AOAM532t9q5FC6i0XN/gAXgr8Wc+uphMwrAIn+1x8bmW6N9CXh5lz1MT
        R8ujg6hzQzAt5iFKyqXyqLoUBw==
X-Google-Smtp-Source: ABdhPJwWobt6pVg/42LLNxfilYuO6c87nDIqhPBmiOFom1mvCywbxa/XGq5HBvenNWiYZUprwDAUKA==
X-Received: by 2002:adf:e883:: with SMTP id d3mr25756288wrm.139.1610975921450;
        Mon, 18 Jan 2021 05:18:41 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id y14sm25110466wru.96.2021.01.18.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:18:40 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:18:39 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 15/21] arm64: Add an aliasing facility for the idreg
 override
Message-ID: <20210118131839.7ao33jeufq3dfnb4@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-16-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-16-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:27AM +0000, Marc Zyngier wrote:
> In order to map the override of idregs to options that a user
> can easily understand, let's introduce yet another option
> array, which maps an option to the corresponding idreg options.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>

> ---
>  arch/arm64/kernel/idreg-override.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 75d9845f489b..16bc8b3b93ae 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -37,6 +37,12 @@ static const struct reg_desc * const regs[] __initdata = {
>  	&mmfr1,
>  };
>  
> +static const struct {
> +	const char * const	alias;
> +	const char * const	feature;
> +} aliases[] __initdata = {
> +};
> +
>  static int __init find_field(const char *cmdline, const struct reg_desc *reg,
>  			     int f, u64 *v)
>  {
> @@ -80,6 +86,18 @@ static void __init match_options(const char *cmdline)
>  	}
>  }
>  
> +static __init void match_aliases(const char *cmdline)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(aliases); i++) {
> +		char *str = strstr(cmdline, aliases[i].alias);
> +
> +		if ((str == cmdline || (str > cmdline && *(str - 1) == ' ')))

nit: Extract to a 'cmdline_contains' helper? Took me a good few seconds to
parse this in the previous patch. Giving it a name would help, and now it's
also shared.

> +			match_options(aliases[i].feature);
> +	}
> +}
> +
>  static __init void parse_cmdline(void)
>  {
>  	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> @@ -100,6 +118,7 @@ static __init void parse_cmdline(void)
>  			goto out;
>  
>  		match_options(prop);
> +		match_aliases(prop);
>  
>  		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
>  			return;
> @@ -107,6 +126,7 @@ static __init void parse_cmdline(void)
>  
>  out:
>  	match_options(CONFIG_CMDLINE);
> +	match_aliases(CONFIG_CMDLINE);
>  }
>  
>  void __init init_shadow_regs(void)
> -- 
> 2.29.2
> 
