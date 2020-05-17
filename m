Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF011D6623
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 06:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgEQErq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 00:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgEQErp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 00:47:45 -0400
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA13C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 21:47:45 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 5E44E63A89;
        Sun, 17 May 2020 06:47:38 +0200 (CEST)
Date:   Sat, 16 May 2020 21:47:38 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Patrick Donnelly <batrick@batbytes.com>
cc:     Al Viro <viro@zeniv.linux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>, xiubli@redhat.com,
        kchai@redhat.com
Subject: Re: file system permissions regression affecting root
In-Reply-To: <CACh33FqzSc26qyvdueZ3ee28j28cyz42n++xnE=BUXe507NLKA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.395.2005162144490.14542@trent.utfs.org>
References: <CACh33FpkBrHpTNfZN6EiyaVPVb6bvJqHO8dJkiHzWPOF0+pKAQ@mail.gmail.com> <20200513161113.GU23230@ZenIV.linux.org.uk> <CACh33FqzSc26qyvdueZ3ee28j28cyz42n++xnE=BUXe507NLKA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020, Patrick Donnelly wrote:
> However, it seems odd that this depends on the owner of the directory.
> i.e. this protection only seems to be enforced if the sticky directory
> is owned by root. That's expected?

According to the documentation[0] this appears to be intentional:

 protected_regular:
   [...]
   When set to "1" don't allow O_CREAT open on regular files that we
   don't own in world writable sticky directories, unless they are
   owned by the owner of the directory.

C.

[0] https://www.kernel.org/doc/Documentation/sysctl/fs.txt
-- 
BOFH excuse #263:

It's stuck in the Web.
