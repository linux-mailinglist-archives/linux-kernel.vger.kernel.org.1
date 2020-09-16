Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91DB26CA86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgIPUEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgIPUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:03:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB8C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:03:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a26so7042698qtb.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MazoKl6IvxkPqAsDdAfaizPzdK2lM2rR4UndvMvYgzE=;
        b=ovVAMVBqcKQ+3PfwvmPrn/MuLOGARpJ5yTFHuLblyrlgNqoxD1KFqTHhGXc4BL7/iL
         M0x61Z5PHO6QUEk9vP4gr8mnOW5a2ZRawcp1uW/7T95L1pEJSXVSKAlmxe+MvU5InYkW
         vckaqwYLHWy2RXUJ8tY65j757UZT2e0UuXaB5jHazNK+ODVOxlBlxRKS9gdPt7dWdvUX
         WvdPfhi8WPclyWzODCSEb0/rccb27Poohx0I0y/X24RJgopxc1yns7qfo37565uij0JS
         6UhgAz68dU6shJMTmFZNNxQNwPGxZlbWxKpJ7+fqzM7SayT2IUVEP40226xqx7gDJ9jz
         qfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MazoKl6IvxkPqAsDdAfaizPzdK2lM2rR4UndvMvYgzE=;
        b=noYios9ZPCidAj/vLc2bGYkJeznpZpWDR5L0vgAwT40Cm7diSVdSq5rIpdwnBIHWk+
         CuAZSvN1VRN27Ot/43tWoMrCPIUvTpCcBRSlhA9sonCDGAJi8+ziUrmWvau0g35RRGEl
         ebANZiNqfdqh3tt26dT/c90XnTPWJHRqKIczMuPSUxnfyNYtGTERPdwAiXLCgq7P8FVl
         UPiUk7LfW1QREkICLCH+Cy+5V9v/vauX/5MdtMKtLtcj9N3H9/aiTvs9lbgadKEPYDDj
         qCamAvt45wfK/CBoxnDspqliQXcWy7baxQiLxku9q/gXS75jt2v8kYBb6sWbRniUKizQ
         vnFw==
X-Gm-Message-State: AOAM532sBxVavCADAqZjzd9Vma9wc1YcTtxn/7kxVzU7B8WYhLI5GFLj
        Bzmp3FoWoooL/bMQ520uiaYoLyvwOEy3yDMildk=
X-Google-Smtp-Source: ABdhPJw5YHT3QrUFee69v9ui/zgYUDAaytZ80OHJJ23jcom0CVWFNiRvIY6DhnqvFVKU9mfvuE78qR6OryWVyEzXfyY=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:f2c1:: with SMTP id
 c1mr16825811qvm.30.1600286585957; Wed, 16 Sep 2020 13:03:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:02:55 -0700
In-Reply-To: <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
Message-Id: <20200916200255.1382086-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2] nfs: remove incorrect fallthrough label
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no case after the default from which to fallthrough to. Clang
will error in this case (unhelpfully without context, see link below)
and GCC will with -Wswitch-unreachable.

The previous commit should have just replaced the comment with a break
statement.

If we consider implicit fallthrough to be a design mistake of C, then
all case statements should be terminated with one of the following
statements:
* break
* continue
* return
* __attribute__(__fallthrough__)
* goto (plz no)
* (call of function with __attribute__(__noreturn__))

Fixes: 2a1390c95a69 ("nfs: Convert to use the preferred fallthrough macro")
Link: https://bugs.llvm.org/show_bug.cgi?id=47539
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2:
* add break rather than no terminating statement as per Joe.
* add Joe's suggested by tag.
* add blurb about acceptable terminal statements.

 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d20326ee0475..eb2401079b04 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -889,7 +889,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 		default:
 			if (rpcauth_get_gssinfo(flavor, &info) != 0)
 				continue;
-			fallthrough;
+			break;
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		ctx->selected_flavor = flavor;
-- 
2.28.0.618.gf4bc123cb7-goog

