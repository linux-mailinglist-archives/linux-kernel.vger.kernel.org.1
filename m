Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B311A2F3FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395070AbhALXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbhALXBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:01:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E999C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:01:03 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610492461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8Zr51lHkren2Omu1+jT+Kn2hyOob3aUDlZfB4G5YA0=;
        b=idfVIxIwTD9xsYTnDegTaM4mc3cltulfR+pzEY3SHxiWO4EyEKydyKnTygNKJc6reYyZS5
        6/MF/EMJmIkPJDQzdt9piHEnUNwDCkinRBJyVGHrtZOmfZm+I53ec0Ua7drFJvpu/fAA2x
        tG8lIGxg6CWFSVI6+kP+EILGuxcGUn3vPgWPExMc0tWlJ8+nPDiTory0ahS8qxozeRZR/C
        e0ly8Z/YtdI4JLVuXATjmQ1duoKlm3cCWIS5J6qCuZ3urcXZPQRSPArn7VZ7FEWjssaS+O
        UBi1LpzVg5XwWoxna9PWDa1w6dy4izZMLDtt8lhRQX6RtllWmnuFlW32c7YNDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610492461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8Zr51lHkren2Omu1+jT+Kn2hyOob3aUDlZfB4G5YA0=;
        b=zAPqNfdutb6CCVYBU0efn6Rlh6KHuUvNfG3Bp/yiI3zDCxPBWCknr3g5Um+ujRv4PjKu78
        JTt/oI7RZ98L7ACw==
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/3] tracing: Merge irqflags + preempt counter.
Date:   Wed, 13 Jan 2021 00:00:54 +0100
Message-Id: <20210112230057.2374308-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the RFC patch posted earlier.
It has been rebased on top of v5.11-rc3 and RT related bits are moved
into the second patch.

Sebastian

