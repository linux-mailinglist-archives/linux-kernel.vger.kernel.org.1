Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1D271552
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgITPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 11:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgITPSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 11:18:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B91420870;
        Sun, 20 Sep 2020 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600615103;
        bh=t1faBIem6NhKyYcM2fXmF4xVqArdCZAvXh4H4f+9to8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yJgEp3eaQW8VXkD6Rw93U33OiVXKM415WI0V5WT1YwDZm/RtYCR8hfWPzcvxdtU1e
         ri3ACgLTtdgi0TtwCBtnW9RNxWU0xzou8wJjhJPSTaRhhURI+3AerNjs4Um56+prbm
         eKtUXgCGh4IDoqsC+MCjQaQGgbEWBKtkH5yHjFHc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E551235227C1; Sun, 20 Sep 2020 08:18:22 -0700 (PDT)
Date:   Sun, 20 Sep 2020 08:18:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Asif Rasheed <b00073877@aus.edu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging list.h: Modified comment
Message-ID: <20200920151822.GA29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200920133154.71514-1-b00073877@aus.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920133154.71514-1-b00073877@aus.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 05:31:54PM +0400, Asif Rasheed wrote:
> We (everyone from my Operating System Lecture Section) were confused on whether the list is circular or not (because no one bothered to look at the implementation). Modified the comment on top for clarification.
> 
> Signed-off-by: Asif Rasheed <b00073877@aus.edu>

Good point!  "Simple" here means "not complex", but given the size of
this file, one could argue that this characterization is long obsolete.

I queued your patch for v5.11, but as usual could not resist the
urge to edit the commit log.  Could you please review the version
below to make sure that I did not mess anything up?

							Thanx, Paul

------------------------------------------------------------------------

commit 8ac8c191b5f1a42b02462d5b35675f2439097b86
Author: Asif Rasheed <b00073877@aus.edu>
Date:   Sun Sep 20 17:31:54 2020 +0400

    list.h: Update comment to explicitly note circular lists
    
    The students in the Operating System Lecture Section at the
    American University of Sharjah were confused by the header comment
    in include/linux/list.h, which says "Simple doubly linked list
    implementation".  This comment means "simple" as in "not complex",
    but "simple" is often used in this context to mean "not circular".
    This commit therefore avoids this ambiguity by explicitly calling out
    "circular".
    
    Signed-off-by: Asif Rasheed <b00073877@aus.edu>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/list.h b/include/linux/list.h
index 0d0d17a..796975c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 
 /*
- * Simple doubly linked list implementation.
+ * Circular doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
  * manipulating whole lists rather than single entries, as
