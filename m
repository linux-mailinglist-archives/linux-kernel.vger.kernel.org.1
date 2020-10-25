Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2467E2983D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419142AbgJYWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 18:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbgJYWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 18:10:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDECEC061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 15:10:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w23so7432912edl.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdnZw76qVstn6+QH2BD9S0uoR0Bw/i7xKme9YhIoncY=;
        b=Q8CS6+MsaiGw4Zr5INAN2zzC4XW2DIX9J5VnnoeZXYKoa1PhBdB/bUmQCvSxGJLmfg
         H/j0bGj6u7MlgKCJsRyunKiLz+F3S+tJlHrHqbiavC7aDWs70sGVJefvtGBHmC0w+sja
         VIiif/8S3WteScdeBev9U7kMRxbHFDDupNnRz2oN2DG4C9PVkyxcKVL+FWdE1Tvm+hQa
         /Yd28N1I/goacLfTxkU3qDW1iunZTFcGrLrn7nvrHzIoZqx9gU7z+9oNY0awUi/8HOs0
         wOxe2zhqKYDgUnpbyttTr23ACyIRIJ6td49w4mTjwA7lb/ufVR4ntiWHvqJZhilPD1uW
         npuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdnZw76qVstn6+QH2BD9S0uoR0Bw/i7xKme9YhIoncY=;
        b=lssuZO5gRpJEAtCXLwCh4Hr2WqGAjvzx46CajFUqtIxYwscMgexJ49z3W8Tax3FFGg
         O1GZYI3g7H8XWEpEoAoYt0DilRfd3/P1in7GFC9u3iw1YKws0aTaVCRyUgJLuNkvzoRI
         x+gW68r80XvlPHVc35iTEpsr5Nivd2syf9MrMnKyyNaV1MVb8+C8ud8mDkLIoNFzyJZ8
         +AH28bBAHAyn7fUh7KzkKmBfv45WMrTFPT34yq2jXW1q+awogaVZ9/bugtW3GOqkTEDQ
         E6SYHaDvKVDNsisNEeCB9BhaKCDdGl6b4Vg4S+EhgsWpmtP32IKDZh+K2N735mLKsCZ+
         6YEA==
X-Gm-Message-State: AOAM531+y7mxFr7RVMBm9++V4f8EEvSKsQeT3h29P8p/Yy4bC54iqtWj
        7F0hi4aTMepvf0A3r6oLtTMWTXiR1MlLPz2plVqw
X-Google-Smtp-Source: ABdhPJyLEBWv9F4YhwzynfMYVBexdD3GqbUxbBH+vngsdu+ZtVKMJPGPu3mdw4W34PdPX4g0n5METweLV5QzVVSUrKY=
X-Received: by 2002:aa7:d689:: with SMTP id d9mr13357034edr.128.1603663855471;
 Sun, 25 Oct 2020 15:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org> <8c04d5c5d0144019c2c38d7c3f31061d6b35d360.1603469755.git.mchehab+huawei@kernel.org>
In-Reply-To: <8c04d5c5d0144019c2c38d7c3f31061d6b35d360.1603469755.git.mchehab+huawei@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 25 Oct 2020 18:10:44 -0400
Message-ID: <CAHC9VhQ88cuU-0QdpYJyJZE3FU-3graP=N9n9eiG4Kj2tDbiBQ@mail.gmail.com>
Subject: Re: [PATCH v3 51/56] audit: fix a kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 12:33 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> typo:
>         kauditd_print_skb -> kauditd_printk_skb
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me, nice catch.  Would you like me to pull this into the
audit tree or are you intending this to get pulled in as part of the
larger patchset somewhere else?

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 68cee3bc8cfe..0be42cac086b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -523,7 +523,7 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
>  }
>
>  /**
> - * kauditd_print_skb - Print the audit record to the ring buffer
> + * kauditd_printk_skb - Print the audit record to the ring buffer
>   * @skb: audit record
>   *
>   * Whatever the reason, this packet may not make it to the auditd connection
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
