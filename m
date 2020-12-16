Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE17C2DB997
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgLPDSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgLPDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:18:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43308C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:18:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x20so25232882lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+Z2tHiW9avf7JpbvUchHLSGIDTfu8oxZ6UR0ggmJn0=;
        b=VjTGKB+LEOEwguo9FjmWrUWqAtvd7qphV0zEvfivlP32wAgOPCulGnYdMUJKp+9fFF
         maVF81pFs9/gQTcHRmSJmS2aKH3dDFjhCCmCCwgNH5xe1MK51UQoqhPVhmpKTNxt4PoU
         cG9zvpb7hKJN95unzKncVlaH3h99b9eWZxH14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+Z2tHiW9avf7JpbvUchHLSGIDTfu8oxZ6UR0ggmJn0=;
        b=RufYfKmYFFXYsfQRedvHmo226U6XE1ddZq8beYRPhSfcZSNsE+A+8aM4PBwW/0GSWR
         GMejGmbUOlZElee4E8qN4yXhyzi3zs7wvihXvPk/m+xT/BHNFXhB0EEL7WtLXDFfJuBc
         600kcM0eJiEiCOY0TiY4QQOkmZ4YomX6Wi1ln5Z3SxDf/1hpRYfJBBHcknTe63Sc8jwc
         BWcxZ2qJSE67H/VE2lRIHwaaH/fq9VEk+5vivIpWvvtBe/Xaqb2oFXKIoJmtAjZ1zAg4
         zguCdgDayi0lk54wm+YzQiri94K6mXM+VkHLJIr8uHKmc03H76lxpxqExHtet8s3gOUe
         k0fA==
X-Gm-Message-State: AOAM530vfNBZfUtVOQ6gNugckNBSZie5Xzkk+JMln5HYUzB/wddRCikr
        IzPHV33KZhXvvFVKgxW9i/ki0gd5lnwjag==
X-Google-Smtp-Source: ABdhPJxCnv0wLQcmGTGs/i/YVlps5NRXMUCVG2LqASX8gMPYxfI2m5V+ler7PmoKpvC5foymkEwGJQ==
X-Received: by 2002:a19:8b88:: with SMTP id n130mr11586172lfd.527.1608088688256;
        Tue, 15 Dec 2020 19:18:08 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l24sm110128ljg.65.2020.12.15.19.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 19:18:07 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id h205so1255193lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:18:06 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr13175417lji.48.1608088686543;
 Tue, 15 Dec 2020 19:18:06 -0800 (PST)
MIME-Version: 1.0
References: <87bleubsgy.fsf@x220.int.ebiederm.org>
In-Reply-To: <87bleubsgy.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 19:17:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtA2_hVzp+NdiNyMSWZ02hBguB0LVFqas9sMxi081tkQ@mail.gmail.com>
Message-ID: <CAHk-=whtA2_hVzp+NdiNyMSWZ02hBguB0LVFqas9sMxi081tkQ@mail.gmail.com>
Subject: Re: [GIT PULL] signal enhancements for v5.11-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 2:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Most of this I believe has already come in through Catalin Marinas pull
> request "arm64 updates for 5.11".

Yeah, pretty much all got merged that way earlier, so I edited your
email heavily for the one remaining part that this pull brought in..

          Linus
