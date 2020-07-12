Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DBB21CB78
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgGLVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 17:03:49 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59482 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLVDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:03:48 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CD7E91C0BDD; Sun, 12 Jul 2020 23:03:45 +0200 (CEST)
Date:   Sun, 12 Jul 2020 23:03:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fixes for v5.8-rc4
Message-ID: <20200712210344.GC983@bug>
References: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> /* Summary */
> This contains an annotation patch for a data race in copy_process() reported by
> KCSAN when reading and writing nr_threads. The data race is intentional and

Would "KCSAN fixes" be better subject of the pull request? fixes is a bit
too generic...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
