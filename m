Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7229A96F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897953AbgJ0KUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897942AbgJ0KUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:20:42 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED48922264;
        Tue, 27 Oct 2020 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603794042;
        bh=tC18bzW4JkPBFDUHYcALgWxOKR2muT+CvC/Ly3k/fxg=;
        h=From:To:Cc:Subject:Date:From;
        b=orrjiV7dpQ57wbZTzFjWLvKZXNhi5DH4CB5kfKpXqn+ucvhbi5TJVgi3wNCjEVMUC
         dC/TNiN6R8VC8rY2FZnkowY5RnoH3tzSwNOo8HMbcjz9PfX9LuF32/1r1VwzsG/YIm
         QGd9OsKMQZwVLW4fnbhMyvDp9pufwEAwp/0Ivi4E=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXM5n-003Fge-Es; Tue, 27 Oct 2020 11:20:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 0/2] kernel-doc: fix typedef function parser
Date:   Tue, 27 Oct 2020 11:20:35 +0100
Message-Id: <cover.1603792384.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

This small series contain the latest version of the typedef parsing
fixes that we've been discussing as:

	[PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing

As I said there, at least while discussing it, I opted to split the
patch in two.

The first one changes the regex;
The second one is just a cleanup that splits the 3 arguments into 3
vars.

From my side, I'm not 100% confident if the second patch is
worth or not. 

The advantage of it is that it makes easier to read the regex. 
It also also makes clearer about the differences between
the two typedef regex'es that are used there. 

On the other hand, using a site like regex101.com to
test it is harder, as one needs to copy-and-paste 3 expressions
instead of just one.

So, when appliying, feel free to decide to either:

	-  merge both as-is (two separate patches);
	-  fold them into a single patch;
	- drop the second patch.

Mauro Carvalho Chehab (2):
  scripts: kernel-doc: fix typedef parsing
  scripts: kernel-doc: split typedef complex regex

 scripts/kernel-doc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.26.2


