Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0232A25BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgKBH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgKBH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:58:46 -0500
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7943421556;
        Mon,  2 Nov 2020 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604303926;
        bh=reFXUFkZyreQdSjvxNIW/3zmr/r2nAc+7XF6Gl9WkEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YyIOOKlGgEYnez7PGXlkhgyDy9YZgDb0zIfFZQiknJ+VuzcrsxJwQyQsjmj5l2at6
         7fvLh0G8fopdVFdeBVhbqlP20u0FLdnnDIWTF5f/8DOCX5bgLA0egw0XojdweEYT+v
         9Nw82X29S/6LXJjkAl9hzxQTWgd+fKyQ2XIz89uA=
Date:   Mon, 2 Nov 2020 08:58:41 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10-rc2 (docs build)
Message-ID: <20201102085841.5490f6da@coco.lan>
In-Reply-To: <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
        <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Em Sun, 1 Nov 2020 16:01:54 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Something broke the docs build (SEVERE):
> 
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
> 
> Attributes Common for All RapidIO Devices
> -----------------------------------------
> 
> 

On what tree did you notice this? Linux-next or upstream?

Using title markups on ABI files is problematic. As they'll
all be placed as a single document, the markups for level
1, level 2, etc should be identical on all files that use them.

A quick fix would be to replace the above to either:

	**Attributes Common for All RapidIO Devices**

or just:


	Attributes Common for All RapidIO Devices

I guess it should be easy to change the get_abi.pl script to
just ignore markups that matches something like:

	^[=-]+$

That should be more reliable long-term. I'll write such patch
and submit it.

> and then it stops/hangs. Does not terminate normally but is no longer
> executing.

That's a docutils/Sphinx bug. Once I wrote a dirty patch fixing it, 
but I ended losing the patch[1]. Basically, when severe errors occur there,
it tries to wait for all processes to die, but this never happens,
causing it to wait forever.


[1] I guess I did something similar to this very dirty hack:

--- sphinx_3.2.1/lib/python3.8/site-packages/docutils/parsers/rst/states.py	2020-11-02 08:50:21.602785381 +0100
+++ sphinx_3.2.1/lib/python3.8/site-packages/docutils/parsers/rst/states.py	2020-11-02 08:52:45.216612493 +0100
@@ -371,7 +371,7 @@ class RSTState(StateWS):
         error = self.reporter.severe(
             'Title level inconsistent:', nodes.literal_block('', sourcetext),
             line=lineno)
-        return error
+        sys.exit()
 
     def new_subsection(self, title, lineno, messages):
         """Append new subsection to document tree. On return, check level."""

Thanks,
Mauro
