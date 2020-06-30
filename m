Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37E3210081
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgF3XhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 19:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3XhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:37:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:37:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so10207600pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwnTIUpl4Z9SyL/We0nzSfYkibBG9NQmHMNaAhO+Afk=;
        b=cqBxdZVU6FSIAzp/DtiImlkxrgSyPy1w3FKIfnkd/s5I9dFztiqgFCZ8tAsy5+/dpO
         uDHgeBQcraEKej9lo4pTg+TTInU4U/YW3E0lgnbyGpngZL3ppIkBOriyDzZCuFme0aAU
         SeO13MGZ5hZHyWRlKPOyeVO6FQgLKaWdIDpos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwnTIUpl4Z9SyL/We0nzSfYkibBG9NQmHMNaAhO+Afk=;
        b=alC8cvHlaoQtDFArghND3mvkMml0O5xRRJ0ncSGvy+KAykvCbJAai9pMdrWRxN/j0V
         wLaFdJtYsKwjFQVrXAqzrnen4hwjP28iUjNv9ajYoKqyM6MmHxxAMdJH6tTfXNj3VFZY
         lt8O2v8OLx6cinhxmRzbXt7eXDeWgK2B7SuZQl+u87FcojIJnLWmZFolS+MhaMNO6FJr
         5P77J8IDBz6c6qbxTlNWxZOxu/8QuwubiHKjCw19tR/Oge4FVXGmAZav4VWRm/OT8zb/
         Yku0QynkTWuW3GLAJczzDeeF06OTYBd2Oks6wzpiTy+iqW8Pqr1KKPAyyrqeJ+KIrDjF
         ofhw==
X-Gm-Message-State: AOAM5316nHmCIViP8/oCVqSTE1aXIEvzmHxcW3584hlrZwMcMzgyJxt9
        KvUBZgrpeM95wMh/caqHwPZBLA==
X-Google-Smtp-Source: ABdhPJzp8Ls73HghT2zU/dMp64VGxtzKH5Ohxr00uTutcC+tOxtk7rWO8haK1rt8tZpH++luCxrTxw==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr12128164pll.79.1593560232556;
        Tue, 30 Jun 2020 16:37:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 144sm3738122pfb.31.2020.06.30.16.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 16:37:11 -0700 (PDT)
Date:   Tue, 30 Jun 2020 16:37:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: sc7180: Add OPP table for all qup devices
Message-ID: <20200630233710.GJ39073@google.com>
References: <1593506712-24557-1-git-send-email-rnayak@codeaurora.org>
 <1593506712-24557-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593506712-24557-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:15:10PM +0530, Rajendra Nayak wrote:
> qup has a requirement to vote on the performance state of the CX domain
> in sc7180 devices. Add OPP tables for these and also add power-domains
> property for all qup instances for uart and spi.
> i2c does not support scaling and uses a fixed clock.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
