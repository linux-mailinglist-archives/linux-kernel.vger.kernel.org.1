Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033092E22F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 01:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgLXAXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 19:23:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50868 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgLXAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 19:23:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A05CDABA28;
        Wed, 23 Dec 2020 19:22:39 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=6i+GsGvjaIwTG0oc1yqVf0q2iDE=; b=lw+NOgx
        NW0OD5igfxJVglZIMqvvnYuosaTP1+PEyzgewu1tSvVpvcaMVGuv6hBUfhaTtX96
        gm2r6MogJJ5Qm/9Brx6wt/5uraB9tPNN33L2RwSs6NjiSmAW+uicynsDnUBalp5m
        O0ivb1eYGYjwD+Jh6xNqNDw9VoZr9bBJJBRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=psaosgfypJ0Lgh5Zs4sLyRwEeVS4WKPkz
        a4+Zg0/1kUFPYct0s+Jzy9ujQ0i6p0GtB4XhKPK+HvI08DMb5FC39wwqqFuZsxme
        +48vlRYCin65V7SXP7bGoARNPVLFc2b+JmjN4dTlVAXbu8vrh1tqID8Z061hsS3F
        VNonpQVJM0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 979BCABA27;
        Wed, 23 Dec 2020 19:22:39 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.178.181])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2517FABA26;
        Wed, 23 Dec 2020 19:22:39 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 23 Dec 2020 19:22:37 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.30.0-rc2
Message-ID: <20201224002237.GY748@pobox.com>
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
X-Pobox-Relay-ID: 214F6D76-457E-11EB-B136-D152C8D8090B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junio,

Junio C Hamano wrote:
> Git 2.30 Release Notes (draft)
> ==============================
...
> Performance, Internal Implementation, Development Support etc.
...
>  * Adjust tests so that they won't scream when the default initial
>    branch name is changed to 'main'.
...
>  * Test scripts are being prepared to transition of the default branch
>    name to 'main'.

These redundant entries were added in 7f7ebe054a (Third
batch, 2020-11-02) and e4d83eee92 (Fourth batch,
2020-11-09), respectively.

Assuming they aren't intentional (as a hat-tip to the amount
of the effort involved in the fixes, perhaps? :) )... here's
a patch to drop the first one in favor of the second, with a
minor grammatical adjustment to make it read better.

Of course, if it's less effort to make the change yourself
than apply this trivial patch, don't hesitate to do so.

-- >8 --
Subject: [PATCH] RelNotes/2.30.0: drop redundant mention of branch name test
 fixes

While here, improve the grammar of the remaining entry.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/RelNotes/2.30.0.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.30.0.txt b/Documentation/RelNotes/2.30.0.txt
index a9c930ef93..bfe6520074 100644
--- a/Documentation/RelNotes/2.30.0.txt
+++ b/Documentation/RelNotes/2.30.0.txt
@@ -119,9 +119,6 @@ Performance, Internal Implementation, Development Support etc.
    take a substring of test title, in addition to numbers, to name the
    test pieces to run.
 
- * Adjust tests so that they won't scream when the default initial
-   branch name is changed to 'main'.
-
  * Rewriting "git bisect" in C continues.
 
  * More preliminary tests have been added to document desired outcome
@@ -136,7 +133,7 @@ Performance, Internal Implementation, Development Support etc.
  * The code to detect premature EOF in the sideband demultiplexer has
    been cleaned up.
 
- * Test scripts are being prepared to transition of the default branch
+ * Test scripts are being prepared to transition the default branch
    name to 'main'.
 
  * "git fetch --depth=<n>" over the stateless RPC / smart HTTP

-- 
Todd
