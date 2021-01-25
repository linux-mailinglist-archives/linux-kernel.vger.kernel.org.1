Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B997302D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbhAYVBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:01:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44170 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbhAYTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:46:05 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611603915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYUP6E0heyc+RHZHckDtbdtWfyvRcTTUY/yBPYZp9pI=;
        b=2VTBxiKstUOjpkAvbMZT+lzQMLUbjVsAUeE695ekMgnQlMX3zzd0czKgyRzZdoAVJnbMQ/
        nolYg48EODs/sqIe+lkHHFXW+6ss6cCplP+KzIVfNjfFnb9lmAJq4L7JGMTspiP2AvziMZ
        581VTadHtu5dtbgVL5w8Xjfs3QQ68Em4T0YrJEjx2uXiHW5uABabzTfIqJCnwvAW5PdKD0
        by11J5wjXTyCRBtsRHis+3TnPp3hp7TkNWeFAbrfOfRh1ymVVHWsKjWAYdh9XTlma5EzKj
        vA0ajTcfbg6qq9T2XNa+diWpQ297HHE8dFQZYZixXaRRUyySZQ5+j8dtrlSxCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611603915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYUP6E0heyc+RHZHckDtbdtWfyvRcTTUY/yBPYZp9pI=;
        b=GQiZ7qzV8oEp7dEe1z2Y+8BhQT/w0yJNM3uGBIU66mOLy0dgTyTuDBsMyCDeJIdRSvLy8j
        Lc7K9M+1YGb6ZTAQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/4 v2] tracing: Merge irqflags + preempt counter.
Date:   Mon, 25 Jan 2021 20:45:07 +0100
Message-Id: <20210125194511.3924915-1-bigeasy@linutronix.de>
In-Reply-To: <20210125140323.6b1ff20c@gandalf.local.home>
References: <20210125140323.6b1ff20c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The merge irqflags + preempt counter, v2.

v1=E2=80=A6v2:
 - Helper functions renamed.
 - Added patch #2 which inlines the helper functions.

Sebastian


