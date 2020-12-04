Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEFA2CF3A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgLDSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:08:19 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B4C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:07:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so6191196wrv.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject;
        bh=u1vfIZY2aFCzLzqooC8Rt9/rYcFxDLUtih7SLGTE7Qg=;
        b=C4uCG8gmoZbmrGKxZpBg7A0iqZaaOWuWOZxQbaFeKeZWQNftSBcyhaR25jy3rJTXgK
         5ykzrd8yw7Dof9oVLL5fIa5mKjJ2Oh3sNSezmQaulUTMbCjbWlnxU8k0H1lP87C2Os8W
         6j+p0RtvcqQx0q9RUVCPxoCA8x1QJRPQokzqKRkh6DTPTeulg+Pgt/r7oLI6SN/rFgOz
         avZhKsIOd1BYQRGFu/DNBHYCZpXGMElvABgHvZH4oLUZf970hmZUQEWMkS6qieWmPpJL
         XeJ/R98ZVy8PTZ6/Y1WudiugzstTkItUfiie8Vg9031HChQ0HoiwlDvPFonyuZx8yycv
         beHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject;
        bh=u1vfIZY2aFCzLzqooC8Rt9/rYcFxDLUtih7SLGTE7Qg=;
        b=Baw/4wnk//+CpUJj8gMjl5vuIrWecBbR0Loso3mv8L023U3YfrOFyJE/nhMceKVFuV
         QdSzEbg2pFxkbs2Z2GZDtb+nTZF66GlJYMGOF3Ce46QYbNqmyYvXWKPXYbBmuqVjROLY
         9nRlil7mFeaSHKZ2Yteo7nJudxfkePh0yzszxYWxX1MlXDsG8IpJubjUQtJqfRy2XXR1
         Xcfaig0ObJFvGQiwydqzG/Tf7I/wPFWvThqMZmP63pHOuZvUUxin0+lUr2HpTRu5zAqE
         nfEMppunZmKAABAIgLGQZRbMSU8vOFx+m3EXT/EBwrvRAa0nle1i9UrbBw3mOoqYNIie
         /Hsw==
X-Gm-Message-State: AOAM5303/qia4gOPIVxXNOmMCqlqpzx/mll/ZHESJF/UUCoRDtVdk+CD
        ONpjFjuywgSvyImzJVoj8FWZcdCE91CG2w==
X-Google-Smtp-Source: ABdhPJwI7ENAr8moUTXkfec90qkZQPrtziNV9wtY/ugaiyGULNkH2Qlz69tGNOPPE3lER98lsTs3pg==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr6243117wrr.119.1607105251367;
        Fri, 04 Dec 2020 10:07:31 -0800 (PST)
Received: from webmail.webmail.com ([196.170.9.177])
        by smtp.gmail.com with ESMTPSA id g192sm3928909wme.48.2020.12.04.10.07.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:07:30 -0800 (PST)
Message-ID: <5fca7ae2.1c69fb81.5584f.e5a3@mx.google.com>
Date:   Fri, 04 Dec 2020 10:07:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7576789699697519707=="
MIME-Version: 1.0
From:   =?utf-8?b?TWF0dGhldyBBREU=?= <matadtgtg10043@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Priority: 
X-MSMail-Priority: 
Subject: =?utf-8?b?Q0YuLSBIRUxMTyBJIEhBVkUgQSBGSU5BTkNJQUwgUFJPUE9TQUwgRk9SIFlPVQ==?=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--===============7576789699697519707==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Cg==

--===============7576789699697519707==--
