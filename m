Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0A29659A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370532AbgJVUET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370520AbgJVUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:04:15 -0400
Subject: Re: [GIT PULL] remoteproc updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603397054;
        bh=BxPrmRgSW8oWq98l90CJTmzwcFlM69TLwCPYpNwyuDU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aeHXMOf3Uur5vkDqx7tzs9JNhGfYhkgjIZJ0WPVxHy0sFAjnmv6LjyQHr2EL4oWex
         R2F+p0SuWa0vJfXExgFTpzggc+Hf+gkvhcJlTZ82vhVu/nKa0kYHQVdDyV77P1Odt8
         h8yJ25l/CXaJWEf09BD7z1b/6HIoWIH0RBdAcp+s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022163246.21438-1-bjorn.andersson@linaro.org>
References: <20201022163246.21438-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022163246.21438-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.10
X-PR-Tracked-Commit-Id: 141bc97c1bfe31397b2a12e5676d0c2692c8e07e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1553d96854b47953e41e7f66b2bdbc1c0d13a3e5
Message-Id: <160339705480.15216.3134357892949638725.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 20:04:14 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 11:32:46 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1553d96854b47953e41e7f66b2bdbc1c0d13a3e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
