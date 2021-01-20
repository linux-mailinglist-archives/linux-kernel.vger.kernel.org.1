Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2142FD646
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbhATQ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391736AbhATQ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:59:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F12F233EF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611161928;
        bh=v7nlydOKYBAsJsCf/q26TX06Nkq+tas/clcVk+BeKwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iPxpeOaqOg7jlnqB3pjrD9xY37sXhjAH/cfF23KXAT68FVTVBazeRarEVATGB1ASA
         HnxrvjLgOy8ix3zau6OOCCw1Ys1nkBXELfxgh/k9wz/uMY7vu6b06UZYkNPKoSZRV/
         1xOTHOoMM0d+xoRrY5KbnDeUmGZjTtQJZ54jgUHsb01SuDEdDF2EzfbcXQDPoFbjoJ
         YXYugr9/l/b2HcmbCV6XQbo7ILgktIRc3L3ZQMz57p7R4/CBS3p9e4jkACSm+1gTtd
         iwDC+DoXBVnHcikhUvsLEci8GamMmki3uAo/zJCBmFeN+4+9gw9fIZwCXNvHTl1MT+
         kO9VwXpzV0sVw==
Received: by mail-lj1-f175.google.com with SMTP id u21so26965918lja.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:58:47 -0800 (PST)
X-Gm-Message-State: AOAM531dPMBiA8+sraiQcUfw9l2dpmFfk5uTAJaRs6hZhRoKoJDdwdmF
        PecMcH9vY/bDsLLg8T4RYScL6G1Ik0xfR61/t2Aztw==
X-Google-Smtp-Source: ABdhPJwGYgwwaNer71VlQhfBHKFPJd3bzShpGLw4SF5PAAWUJpaYwqIxrKck8//dr5tKm62g8ORkN/W8oB9xBWKb724=
X-Received: by 2002:a2e:9b1a:: with SMTP id u26mr4888757lji.187.1611161925940;
 Wed, 20 Jan 2021 08:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-3-revest@chromium.org>
In-Reply-To: <20210119155953.803818-3-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Jan 2021 17:58:35 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6WisUDuMrb0h8gid4_QGqpCjfURFbz7e=xRgB98LS4tA@mail.gmail.com>
Message-ID: <CACYkzJ6WisUDuMrb0h8gid4_QGqpCjfURFbz7e=xRgB98LS4tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Integrate the
 socket_cookie test to test_progs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
>
> Currently, the selftest for the BPF socket_cookie helpers is built and
> run independently from test_progs. It's easy to forget and hard to
> maintain.
>
> This patch moves the socket cookies test into prog_tests/ and vastly
> simplifies its logic by:
> - rewriting the loading code with BPF skeletons
> - rewriting the server/client code with network helpers
> - rewriting the cgroup code with test__join_cgroup
> - rewriting the error handling code with CHECKs
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: KP Singh <kpsingh@kernel.org>
