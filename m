Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552102E1856
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgLWFUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 00:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgLWFUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 00:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608700752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vW2cW4TjsKdveYtKoF4OGqFRdopX+oDho5T11toLq90=;
        b=R+u/HNNFiYVHnQ6q7UENI455AlwHevhyYeatzR03hQDCHcH0nxOLBaiuiRffOUL3oYfs9i
        6dj0lY7yehHnLu/hGcGLX34ohKloDEMtRkVciFGYwLaEejNzIS9H77UZeQPsI1Ig+NX02G
        oMQWhR3eK7YxS4OFi2q2euw6OXp5Ffw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-lUw8cNt-Px2VJC9L_UNyAQ-1; Wed, 23 Dec 2020 00:19:08 -0500
X-MC-Unique: lUw8cNt-Px2VJC9L_UNyAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEDE3879500;
        Wed, 23 Dec 2020 05:19:06 +0000 (UTC)
Received: from treble.redhat.com (ovpn-117-91.rdu2.redhat.com [10.10.117.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C619719D9C;
        Wed, 23 Dec 2020 05:19:05 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/3] Alternatives vs ORC, a slightly easier way
Date:   Tue, 22 Dec 2020 23:18:07 -0600
Message-Id: <cover.1608700338.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches replace Peter's "Alternatives vs ORC, the hard way".  The
end result should be the same (support for paravirt patching's using of
alternatives which modify the stack).

Josh Poimboeuf (3):
  objtool: Refactor ORC section generation
  objtool: Add 'alt_group' struct
  objtool: Support stack layout changes in alternatives

 .../Documentation/stack-validation.txt        |  16 +-
 tools/objtool/Makefile                        |   4 -
 tools/objtool/arch.h                          |   4 -
 tools/objtool/builtin-orc.c                   |   6 +-
 tools/objtool/check.c                         | 190 ++++++-----
 tools/objtool/check.h                         |  22 +-
 tools/objtool/objtool.h                       |   3 +-
 tools/objtool/orc_gen.c                       | 308 ++++++++++--------
 tools/objtool/weak.c                          |   7 +-
 9 files changed, 315 insertions(+), 245 deletions(-)

-- 
2.29.2

