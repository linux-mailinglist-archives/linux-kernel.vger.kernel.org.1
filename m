Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E528C682
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgJMAyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgJMAyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:54:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83508C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:54:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so25870894ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6HukdDFPy45a3aIumcfc0MFcpWuJbnHPSUT8UUjL53A=;
        b=1bqR9/juzSQC+N9kV6Ixqtt4rzlG3KD60RzkiYZJj0EGkkWi2PHcy2THNv7PqBHxpC
         vcetpboy/CEsWhKqw2WmuQEqg2m38fTXC+THsjqjf97UsK/bMwNbl88tYPsJlqjgHLib
         4SU7Qez+ShkEgwgKWbIxQBfGuk369jiAAZmIO3Q0j+x3mtqLW3g0NmCuZUBq/6g4yRVy
         btDHEINq6QEQVrA7P775+Pq/+z/4i0/ce/D019v3VOdu/oARdhodCsw4lUaJtfZbXe6C
         VvHc3hsfOj8BxMeajh3Ee7o/fSBpR9vVich7a55GPnYohWgqYpNnjaw3Wp+Rd7ezziie
         cuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6HukdDFPy45a3aIumcfc0MFcpWuJbnHPSUT8UUjL53A=;
        b=Ka4PBARQg+5tj6Rq6HDldJS8Eh28IumeoR2xMExFVRggkSq78XQS13QlAqrhb6I5Gb
         wuwq2l+uvVbxhVvrBzqEHzS6pWpxrSSptfkt1PRp3dw9/C82F8OQ52SOvauKV5nXdoc0
         a+RuUMhEmd2KQSa1W3k9kB+QJN7qy4Dybm6qbQ+Ax35L+r0891+j23mOm72Uma58PcBq
         mct7LKdo13j29uktx5YKgfFjbTZ4jWTZbau8vQmE6kT15jaVJ58dauhB5DCZ5/iZGXpB
         aa9IenlfTgmnLOF9yrlr+4fl6E1XObfMtsKxEApBwAUXvZLQxcxmZ3a78gV9+1548n3j
         EqdQ==
X-Gm-Message-State: AOAM531PfVRIalLOEJe6tXai2V/c345e/qs1LzpsFHdZnv1QGETYcdlZ
        wefvJJK6cyH2qHz09WIoY5BbpM3BahEVKSGXnXqKr3BoH4R/
X-Google-Smtp-Source: ABdhPJylnZ+0gGDHO99ud6Ze8t5ualUVdgCroLu4d6mSfa9ZZGXwZFHFaX6ABjoQ25hgWA9Rmdc0975AWl/utA6bBkA=
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr30265414ejb.91.1602550468068;
 Mon, 12 Oct 2020 17:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
In-Reply-To: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Oct 2020 20:54:16 -0400
Message-ID: <CAHC9VhQrBHr00Lxeocv9FkWP5svcEF1=y_9KTRf7Q0-P2ZZJkg@mail.gmail.com>
Subject: Re: [GIT PULL] Audit patches for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 8:51 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Hi Linus,
>
> A small set of audit patches for v5.10.  There are only three patches
> in total, and all three are trivial fixes that don't really warrant
> any explanations beyond their descriptions.  As usual, all three
> patches pass our test suite and as of a few minutes ago they applied
> cleanly to your tree.  Please merge for v5.10.
>
> Thanks,
> -Paul
>
> --
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
>
>  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
>
> are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
>    stable-5.10

My apologies, I mistakenly sent the branch and not the signed tag, the
proper PR tag is below:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
audit-pr-20201012

> for you to fetch changes up to c07203516439b9cd9f7b3cbed82a77164de5af40:
>
>  audit: Remove redundant null check (2020-08-26 09:10:39 -0400)
>
> ----------------------------------------------------------------
> Jules Irenge (2):
>      audit: change unnecessary globals into statics
>      audit: uninitialize variable audit_sig_sid
>
> Xu Wang (1):
>      audit: Remove redundant null check
>
> kernel/audit.c | 9 ++++-----
> kernel/audit.h | 4 ----
> 2 files changed, 4 insertions(+), 9 deletions(-)
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
