Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1032EB41A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbhAEUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbhAEUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:21:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E967C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 12:20:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so1006819ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 12:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rv1SrFE5LD4HwvhaARCW6Cf819Qp1ZuR7kDclxka1u8=;
        b=mMo5Vd64wLcUxgL3MYNmw3tHT8/xsGJF/faCZFanvDLhUvmJT6OV5tF0itgFLLESnp
         WVMoPUkNcDmFCQKdqpj8wMSLsE5L7NwQ62uZSHp//lVxUKprNsoTuWlmb/Q6n3J2ebSD
         pT9qNQ7V5xnbSaWYuIuzW6z+3DjSX9S+ufYgDilzw+iZagX79aXuM3EtodwlvOArmUXr
         HPVDmddOhy7siyBcsxh+3sjmDslo39+17qS7JRzIQkxo8pvJr0dVS3pDeOtCFGEU9E9U
         /8dubCSQFOdWI1U2K2q7UQzcmKOSk2UZiDFPuMwe7Kgc9+AJH2ya32Fytkb2TXeWD+pf
         S5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rv1SrFE5LD4HwvhaARCW6Cf819Qp1ZuR7kDclxka1u8=;
        b=aDO9n968fcCKs56PJLOrvhSfYqapEQIOT3o+LJa1cOAT7AGbcBygEiAAs2QmjZl8tb
         fbfeFEGRPmon7iNbqRKIswEpL7DbwkZ8oTPFLctPI9wl2pADEhavw2crctJsDKnTeSJy
         NXWP+14pakKleXuB0W1lDAHFpE0Y0c/PC6QVS7bHErjaT67jYRMLzCvsH3Ee30lFMxff
         oZU0oQ4xc3vvTIrDdd6ZZq7PKdxEZZB5dGsuPJOv5QIj/828vjwkQZioHjlC+X0bbM5y
         E1RjDlUdz6kkP72dnOZY7WlnBz00ebTlihzL0llrHJagycGFCkrtLyAvjLxt9boaBOKC
         B8aA==
X-Gm-Message-State: AOAM5322oqbDoTZA6FebdAcwKnCEDbO5pDsigCfH1j/YKWXbbayIzkSo
        F4i3FzrXPif9z1MQHGl7byvHKyTZ8nQWZcDDA0c=
X-Google-Smtp-Source: ABdhPJwuYuEh1S2FQkReGOzfEhm5mrQnP+lyT61YUTwEuuGoV1MlpgJUPHUK9fNAFPJvHi9HHLjP1TzBZWzDo5EbM5Y=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:2e07:: with SMTP id
 u7mr1563888ybu.393.1609878051811; Tue, 05 Jan 2021 12:20:51 -0800 (PST)
Date:   Tue,  5 Jan 2021 12:20:47 -0800
In-Reply-To: <20201230155506.1085689-1-arnd@kernel.org>
Message-Id: <20210105202047.31569-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201230155506.1085689-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: Re: [PATCH] ARM: avoid cpuidle link warning
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     arnd@kernel.org
Cc:     arnd@arndb.de, d-gerlach@ti.com, joe@perches.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, ndesaulniers@gooogle.com, ojeda@kernel.org,
        ssantosh@kernel.org, tony@atomide.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since commit 83109d5d5fba ("x86/build: Warn on orphan section placement"),


Might be better to use:
commit 5a17850e251a ("arm/build: Warn on orphan section placement")

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
