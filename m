Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAB20F290
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbgF3KXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbgF3KWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:22:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFBEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:22:31 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593512547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fdhxUleDcH3X7TGq9dRPAOiAqQUxUd45uRsV7RDsJZU=;
        b=qBYHdon7ILZ9Qqlfcds6C8kNz19NV+oN5wkMzOc0rvP+IeRpkvULLe3vYAfeM1g4l9VTQU
        tIO2jNEoEpVdlg478c2vKEq4Tq1GPIxMpRU/18QgShGrvqRTf8RLe/0kqofyIYN0PoNQKO
        /6x+zBG2j6yr+gUO3Ocr8PJYsSRF9D3vTtzkX3aSnAQ61uB/26WQ3CSGDSvD76MZdHC9nD
        iDJcRxwKQMlvLhnLcU4Vn9zjskWpPulhcEJVtUpI3nrP8Arn8MC/gNYsIzLuKVg7bH9cPO
        L3PYd4/LUSztxDOljYDFiqCleOZkqQ9ovnMApF0l4tXgVVDLVOsw+BrN37AuUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593512547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fdhxUleDcH3X7TGq9dRPAOiAqQUxUd45uRsV7RDsJZU=;
        b=3OrVEtNepVOHkAKcXBBXjtpOK8KhK8WirAFzDwsaoQ9VsdZJp22pW5q1bUmkbftxkBiE71
        e+DcVZAz3XCi01AA==
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>
Subject: [PATCH 0/2] x86/entry: Tiny idtentry_exit_cond_resched() cleanup
Date:   Tue, 30 Jun 2020 12:22:07 +0200
Message-Id: <20200630102209.1143072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiny two patch series against idtentry_exit_cond_resched() after I
noticed it.

Sebastian


