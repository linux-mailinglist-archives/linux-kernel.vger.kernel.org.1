Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1E2909F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410869AbgJPQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409939AbgJPQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:48:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338FC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:48:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v12so1570509ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=kFfjf4cqxqS2UxHCWrfEtDypv5r7sdx7W2lPUX9+ZIs=;
        b=UNUmY1Npk2hhqg9NYakLEd+p5UXBucqKbfVoGajax7q2M4ma70/lZ/4iBqZkvmItE4
         NtkWXwua//Ho9cHuxyjs7qfeNTLAGB2JDZyieFnkd7038NJHm0cCWEsg5TQOSp1NGTj+
         rIww9xyctZAdTQzooWfVE7mpk+TbrfD1cpoKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=kFfjf4cqxqS2UxHCWrfEtDypv5r7sdx7W2lPUX9+ZIs=;
        b=PTbJz9l/MLi/y1Whdqodj26etVdLZ+FZvWVXzJEloGblg+4avUtj3szQ0g4SuTsjNm
         MjCqgPq9TtFKxCbAf8WcPDb52s0/GqJm4G/xb1VvDGkRzY4Qwzm93vuBfMuXBN3mC/6q
         np7U2WlgKUa8DNKP7KIRWKo+VaaFfQABoq15kTeM8tzjFDv5ewuh07IlzZTQfp3dUuLn
         z0rtXkdOY9ilq+owLnmGn50uCnAtvVlbwD66BEYYJxDdnAnY8ZVKxzrH8KdBVojv9Q+q
         fJYzVr9hOh8pU1ONqkHCYHa5OHrERBDq1IWFH/7jU4VE9yzJgvCmJWb+OtkoACxHq+ai
         K4vg==
X-Gm-Message-State: AOAM5330eNPUj0GtX3fLTWY9dqthz05P4ZA6eeheaF/swvBXhfzU8gWD
        kUNMz9MavKw2a5ADTPYvAF09uw==
X-Google-Smtp-Source: ABdhPJztiqahfwi3NF64kDXzs85qi0GlRHBPiQOLs4nQt5T7N5GDK9hWDgbrzSIV7fxCITICBVioyA==
X-Received: by 2002:a17:902:8e8b:b029:d2:4276:1df0 with SMTP id bg11-20020a1709028e8bb02900d242761df0mr4751874plb.62.1602866911093;
        Fri, 16 Oct 2020 09:48:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y4sm3349381pgl.67.2020.10.16.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:48:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200929133040.RESEND.1.Ideabf6dcdfc577cf39ce3d95b0e4aa1ac8b38f0c@changeid>
References: <20200929133040.RESEND.1.Ideabf6dcdfc577cf39ce3d95b0e4aa1ac8b38f0c@changeid>
Subject: Re: [RESEND PATCH] soc: qcom: smp2p: Safely acquire spinlock without IRQs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Markus Elfring <elfring@users.sourceforge.net>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Date:   Fri, 16 Oct 2020 09:48:29 -0700
Message-ID: <160286690900.884498.13659438662199129460@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2020-09-29 13:30:57)
> smp2p_update_bits() should disable interrupts when it acquires its
> spinlock. This is important because without the _irqsave, a priority
> inversion can occur.
>=20
> This function is called both with interrupts enabled in
> qcom_q6v5_request_stop(), and with interrupts disabled in
> ipa_smp2p_panic_notifier(). IRQ handling of spinlocks should be
> consistent to avoid the panic notifier deadlocking because it's
> sitting on the thread that's already got the lock via _request_stop().
>=20
> Found via lockdep.
>=20
> Fixes: 50e99641413e7 ("soc: qcom: smp2p: Qualcomm Shared Memory Point to =
Point")
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
