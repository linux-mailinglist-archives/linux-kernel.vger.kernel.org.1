Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B808419EF41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 04:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDFCEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 22:04:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45788 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgDFCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 22:04:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLH87-00BimU-Nh; Mon, 06 Apr 2020 02:04:51 +0000
Date:   Mon, 6 Apr 2020 03:04:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [non] 2aa3847085: will-it-scale.per_process_ops -32.0% regression
Message-ID: <20200406020451.GQ23230@ZenIV.linux.org.uk>
References: <20200406012539.GR8179@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406012539.GR8179@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:25:39AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -32.0% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd ("non-RCU analogue of the previous commit")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Arrgghh...  Could you check if vfs.git#fixes recovers that?  FWIW, proposed fix
is this:

commit d98d78cd6ac9eb5ed0506140cc43432d7c7dd480
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Apr 5 21:59:55 2020 -0400

    fix braino in legitimize_path()
    
    brown paperbag time... wrong order of arguments ended up confusing
    the values to check dentry and mount_lock seqcounts against.
    
    Reported-by: kernel test robot <rong.a.chen@intel.com>
    Fixes: 2aa38470853a ("non-RCU analogue of the previous commit")
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namei.c b/fs/namei.c
index 61fdb77a7d58..a320371899cf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -610,7 +610,7 @@ static bool __legitimize_path(struct path *path, unsigned seq, unsigned mseq)
 static inline bool legitimize_path(struct nameidata *nd,
 			    struct path *path, unsigned seq)
 {
-	return __legitimize_path(path, nd->m_seq, seq);
+	return __legitimize_path(path, seq, nd->m_seq);
 }
 
 static bool legitimize_links(struct nameidata *nd)
