Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F46B212684
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgGBOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:41:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47887 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgGBOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:41:28 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jr0P1-0001n6-95
        for linux-kernel@vger.kernel.org; Thu, 02 Jul 2020 14:41:27 +0000
Received: by mail-ed1-f72.google.com with SMTP id y92so23813910eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T1+UQfX6pEeNwUce2bRhBzSqya6/7UUz7vTij4e9c8=;
        b=CaUO+FKWf+xz++tTyw0Lr/nGCYr7I067ZbX0WyiojfqFgpBJAsA6fiUfJSR4Ewu4Xw
         1TbSCNP9Qj4LbZ7TwSeubYe6asEQShgJQv55Dd903H4klAU6DErDIq5PwXBFrNWdXC0n
         o5nDxpj83sYehJOPcFaw8Do6dBhg3dLwbji0APYK52qah0X24hz4ty8rf5n4JWWTT+tL
         Xzg4Hhz3Lkbahs80nwnLX5Vmk6JALztmY+B2uAFN9rQY/pTgKYapnph0osDJW9UqChOy
         jV2a6FvrOk8fk7TKViRiCptKoEjnqtAHgrs5ZhbHEHhrAC9Ff/Z+L6MHu8yNWjYXc9xQ
         CPYg==
X-Gm-Message-State: AOAM532Nu4rE2wt/JTSU6tYYl0aHRHxNXS8ROoAr+maRgf7HclH3jpGd
        CU3X+CfTzU1HmDNMRoO2OGVZVH1MPjT4cgb0hwbN6jMD4hnEbS2i3XvvCFzRWxdvpUayOlVPCun
        FpDeEJuiWl/Tcbn2K1A84HsLZhJbDBCXMIgj7CRk5oLj/w6AGozwO83Lt/A==
X-Received: by 2002:a50:f149:: with SMTP id z9mr35819633edl.167.1593700887011;
        Thu, 02 Jul 2020 07:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQQ7loNtaLR0+jJmnqpDfGBBHzTUDZLonufSCrcfmOD7H0vkh/Hs5ZKvmSNwfyCLMjhvtOQI4yxlNus9E8rmA=
X-Received: by 2002:a50:f149:: with SMTP id z9mr35819615edl.167.1593700886870;
 Thu, 02 Jul 2020 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200702113502.37408-1-colin.king@canonical.com>
In-Reply-To: <20200702113502.37408-1-colin.king@canonical.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 2 Jul 2020 11:40:51 -0300
Message-ID: <CAHD1Q_yy2gbBkd31oOJiJk2TU3K4wTV3gVtjLiQo1FW+e=5ivg@mail.gmail.com>
Subject: Re: [PATCH] md: raid0/linear: fix dereference before null check on
 pointer mddev
To:     Colin King <colin.king@canonical.com>
Cc:     Song Liu <song@kernel.org>, NeilBrown <neilb@suse.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great catch Colin, thanks!
Feel free to add my:

Reviewed-by: Guilherme G. Piccoli <gpiccoli@canonical.com>


P.S.  Not sure if it's only me, but the diff is soo much easier to
read when git is set to use patience diff algorithm:
https://termbin.com/f8ig
