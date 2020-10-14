Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBB28E6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbgJNSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389252AbgJNSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:52:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:52:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d24so509366ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ea58qKonMZ+zepzsR2xAiE+MgtpRXlTME0hK3xVsjQ=;
        b=IFb1zks8vuF3XRjUSmADx7e+bVmtKHTmlQ+xKjmszgDcoFm1cXVR0SQ63/oSB2AKq3
         8/+YORXzioGoI60sXYgwD0VyGc5N51cleBaHgx9qdihjEB2tQYvfF4KLE5Z9LVTyIIn/
         Z7xsEvihhcW1dHlOu63rstkWL/3NxlGNguk5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ea58qKonMZ+zepzsR2xAiE+MgtpRXlTME0hK3xVsjQ=;
        b=FSvHhY5rpI9w5xmF3l2ewQiexRN1YTwt2Ef6x6lhnzCZY5vjZtVhthC6SsR33i3MN8
         0ncqvkxPhNt+3OK+1GpbT6bBU9PdiVkFf1VWzLM2vYEXLoMLryAv7LqFU0jMFkCMvERt
         trBW1Lvmi4bNqZfiQ/LNmltcl6BuAS/+jfNbzyG7qPKL6Hg6bd1M7oyy3lPGjLYEcUFy
         teffJHo3ohn0xKiAX/BtwQ4qLNh6lg++J4D0rMfToIdAfScoVRRV71VdUEWdv0u4+5Ml
         gj+4EEoaawTKt+d3/35X4yszkHPdLpZnY1L3xlu30dOMsEdgxo6urxUv+6heREdQ7Fu+
         g1XA==
X-Gm-Message-State: AOAM530uPYXSQxXglQoE6jlT0BB+532YtRH+cSzJH0wg06HVcm6CdC1w
        WMB86P6RAmoHiD5lbJ16SU2B7Co3/96+dw==
X-Google-Smtp-Source: ABdhPJxlcnkt5JF6wUvU/VMRmO2dwaarybNOA7MOU+ss6f67HlVjOVv2hLQFq1t/mGgKOW9Gr6sJUg==
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr30221lja.330.1602701547638;
        Wed, 14 Oct 2020 11:52:27 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m22sm55257lfb.27.2020.10.14.11.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id a7so600115lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr210024lfa.603.1602701546151;
 Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
In-Reply-To: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 11:52:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
Message-ID: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> ACPI updates for 5.10-rc1.

So these clashed with Andrew's patches that I merged earlier
(particularly commit c01044cc8191: "ACPI: HMAT: refactor
hmat_register_target_device to hmem_register_device").

I think I sorted it out right, but it might be best to double-check my
end result.

               Linus
