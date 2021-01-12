Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03BF2F3170
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbhALNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbhALNTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:19:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A03A82311E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610457543;
        bh=QxlCETtS32k+LPaY4zcT2sQ1SLQcnpm7zzvGTTnqbqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QtSBDyWvp4isS3qn5rjH1eZTznRQtXe4tuYqQf8fX2uaBkbv5dbrhvYpeFJ2xsMTW
         /TeKaW4nU0DMcnv9T8lbfJNax4mTh7e+7FBvmKhGhAjP4HGzKcIXN5TltC3wOszbaY
         vcZz8PL+5EdAmBQ5iRm/usv91D5ijP4lfhkDA6kFskowARz8nkagVfAW0WdlCMGKkp
         qNWsoE96r+zLCCAaqQqC2UAwdBqTLmz5A+B5EooPh0dyO5IsStVmse0M23c14d674S
         no1yvz3wAPGeLNl1t24Lfn6amaPGoROY9+Nr/l6+T2CIRErMzrsLQohFr692dS9u1G
         lm4LFc6c6fAdg==
Received: by mail-lj1-f177.google.com with SMTP id p13so2814542ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:19:02 -0800 (PST)
X-Gm-Message-State: AOAM530r5FCfPM38tiDVw/mTVfM96+A6DM3Kxv3sF/IAEy/13UF6zOmw
        PZUiSNh4Sbsxu0qL2d/JBuDwHTY7grQSFd2qYx9mqA==
X-Google-Smtp-Source: ABdhPJxDGMjjn+fCOS2eJetLCjYzgB4ZdWzfeMVxV9oCWbuQAobM2wY6nLdXx6Y05vz40WLfAvac9VF/ZcMI2yCDeOQ=
X-Received: by 2002:a2e:b5dc:: with SMTP id g28mr2024861ljn.112.1610457540650;
 Tue, 12 Jan 2021 05:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20210112123422.2011234-1-jackmanb@google.com>
In-Reply-To: <20210112123422.2011234-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Jan 2021 14:18:48 +0100
X-Gmail-Original-Message-ID: <CACYkzJ55cA5STdeeXuhNEAmNi3QzLznirm1onkXHQyAJqcL_-A@mail.gmail.com>
Message-ID: <CACYkzJ55cA5STdeeXuhNEAmNi3QzLznirm1onkXHQyAJqcL_-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Clarify return value of probe str helpers
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:34 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> When the buffer is too small to contain the input string, these
> helpers return the length of the buffer, not the length of the
> original string. This tries to make the docs totally clear about
> that, since "the length of the [copied ]string" could also refer to
> the length of the input.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: KP Singh <kpsingh@kernel.org>
