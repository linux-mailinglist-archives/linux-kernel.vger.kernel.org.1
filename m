Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1F2FBC71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbhASQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731494AbhASQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u9Q4y96bo6R543WF3WIb9gh7PSMWrwFibDeVZ11baSM=;
        b=Z19oeIUHOmAyjYikkAOQkW9tut0rcbmvC9z4MXkj+5iHL1SpvOfT6X0mmTr6A39/BwXP3H
        OIJVFnmuSBl2HTvLjBFdvZSlMd5ZvNxygl2c3Zce0MD7jXcS76enLocoRHRp76/ZX2EJSr
        r+eKxhJOAUJFIsT/dVJmSgUI9sDlx4o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532--nyJ6JRRNJ-W3Npr5fwQ6g-1; Tue, 19 Jan 2021 11:22:09 -0500
X-MC-Unique: -nyJ6JRRNJ-W3Npr5fwQ6g-1
Received: by mail-ej1-f72.google.com with SMTP id f1so3101157ejq.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9Q4y96bo6R543WF3WIb9gh7PSMWrwFibDeVZ11baSM=;
        b=XofGUH1wkuE++/qS+kmbSdgsIkqNjQUSAxTv+owQVTBaaYL8bBa394AnlrPicgMtXf
         Qj2s3lMPze2NI93jNeHE/7HN3rEsTaiRgNrQJquWTB74pMjSM70lZOVfibnw7jJc91K2
         eo5DwCK6RXyWRLyGDeLi3hjh0gNkVmJBPD2cGwOgK0YicEaANxm5JiWVEQDtMKc12NOc
         4mMft2x187PzdXWJg/YRAm+uDJohHBERQGRyverdwojKE2Y6wjH/Au9SF7ThDI9PvZup
         IxYFRKp3eZiVaOYU3yrMvDHRMXERRUjfQK5O9DoYgV0/H/JYi+LXqEXaldwEw7NxIW+0
         CZlg==
X-Gm-Message-State: AOAM531m6d2enDAkwucxmOUNnuDQDVtXHpa9MCLdqT/EIH3JjcZJvvfN
        2IhY1vd7tN9QAAC4mCq+LuGbcw2uw4FCwYWZW6KbdbPqhPh/zl3N3X6LXtuiIIhRyjwNsLjmczv
        puPC16zik61UN2h9FJ3fZLDmB
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr3576261ejb.355.1611073328353;
        Tue, 19 Jan 2021 08:22:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcHzUnJ7YyoKIR+WDesoLPvRjoftwu+C8P2YCi0ehF8psSXAN/K0sAcoG8KXYJcSh2tch14w==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr3576247ejb.355.1611073328141;
        Tue, 19 Jan 2021 08:22:08 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id f22sm2168066eje.34.2021.01.19.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:22:07 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 0/2] capability conversion fixes
Date:   Tue, 19 Jan 2021 17:22:02 +0100
Message-Id: <20210119162204.2081137-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out overlayfs is actually okay wrt. mutliple conversions, because
it uses the right context for lower operations.  I.e. before calling
vfs_{set,get}xattr() on underlying fs, it overrides creds with that of the
mounter, so the current user ns will now match that of
overlay_sb->s_user_ns, meaning that the caps will be converted to just the
right format for the next layer

OTOH ecryptfs, which is the only other one affected by commit 7c03e2cda4a5
("vfs: move cap_convert_nscap() call into vfs_setxattr()") needs to be
fixed up, since it doesn't do the cap override thing that overlayfs does.

I don't have an ecryptfs setup, so untested, but it's a fairly trivial
change.

My other observation was that cap_inode_getsecurity() messes up conversion
of caps in more than one case.  This is independent of the overlayfs user
ns enablement but affects it as well.

Maybe we can revisit the infrastructure improvements we discussed, but I
think these fixes are more appropriate for the current cycle.

Thanks,
Miklos

Miklos Szeredi (2):
  ecryptfs: fix uid translation for setxattr on security.capability
  security.capability: fix conversions on getxattr

 fs/ecryptfs/inode.c  | 10 +++++--
 security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.26.2

