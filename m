Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0983B2D4328
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgLINYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgLINYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:24:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27714C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:24:00 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so1468489wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SL6msqiYJNjRfO6GSKcCWS1H/vFhMdg8DRvJwX7TWvI=;
        b=bair6t1gQ0gVLR1zC0rKXgnoFeQOROlLEGFUf230op7Eo8hgh17TG5/9aBfCAI1qcD
         0bf25IS4q1Ux2U7LHFB/ZPgmrvEbnIszhsm+gSd4/iX/uq9dtl9TYE7kwxoxTOaGUJi/
         lFAHPLK4O4DL3ki+FDMxke9VxA9sMvkZVWLi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SL6msqiYJNjRfO6GSKcCWS1H/vFhMdg8DRvJwX7TWvI=;
        b=VeqTnQCIqEEc+CluddWk7TVsektU4vYXsGkR0YsbLcR71bI7Sic3Lq8iYKBNT/ljrW
         AiLxNhqCkTRQDR9o2I7iHnfRLfUwE7KlMxbj3/LEH/6b/E4q+ihsR2ibcl5R//KcQKmS
         bMd1f9AvO6BMDyxO2zZFFjLwDLBV8iOB79K6MjP+FBY1EzO3sNN8iVFFew9l3U9JjMUs
         mo7MtBTbtKEIkeE/7rUANOQQLrXJGoJ+c+uyLXQZKXUO0BtE/OvvzOKw7iFacqPk7QBh
         x4k5xeWI+V+F9hNRibGesfniCdyfJX6BJeC5bfBg0BFyol6nlBX838qPZRO0atkcxaYT
         +u6Q==
X-Gm-Message-State: AOAM532I4mpjPpzeNrXx/gMkCaht76MKcUGUBWB3ZyH4o2qX7HGRDOPa
        PLOTFKi2Uq9ngVcB2hH5ZqicnA==
X-Google-Smtp-Source: ABdhPJxUVYjsNq97or/ZsOXlsUivBgB/hGt9elBF4gRMMx4dzqrjNIBi0qpfudtlShJCov0cs6MUyA==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr2795827wmc.117.1607520238887;
        Wed, 09 Dec 2020 05:23:58 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id 65sm3405049wri.95.2020.12.09.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:23:58 -0800 (PST)
Message-ID: <38abab69fb724ebb25715bd362b4d187ae37cdf2.camel@chromium.org>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
From:   Florent Revest <revest@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Date:   Wed, 09 Dec 2020 14:23:57 +0100
In-Reply-To: <CANA3-0c5NtYVGa_TQqY36ZWhmFztrgmKgA9Karo-HpW0MBTkPw@mail.gmail.com>
References: <20201208201533.1312057-1-revest@chromium.org>
         <20201208201533.1312057-2-revest@chromium.org>
         <CANA3-0c5NtYVGa_TQqY36ZWhmFztrgmKgA9Karo-HpW0MBTkPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-08 at 23:08 +0100, KP Singh wrote:
> My understanding is you can simply always call sock_gen_cookie and
> not have two protos.
> 
> This will disable preemption in sleepable programs and not have any
> effect in non-sleepable programs since preemption will already be
> disabled.

Sure, that works. I thought that providing two helper implems would
slightly improve performances on non-sleepable programs but I can send
a v4 with only one helper that calls sock_gen_cookie.

