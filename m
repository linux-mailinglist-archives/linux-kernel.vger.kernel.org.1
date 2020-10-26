Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE2298A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769730AbgJZK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:27:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768334AbgJZK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:27:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603708041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+sNJyL5dbOwF5sddomoHWnKiwHRAinIMitE7aE0IfQ=;
        b=dhI0aena6PHhCmh7vvXgBnAuMBRj06NIYz2wZXPWrhAqodsc/2cyGqADJuu6a83l86gFNo
        OBTYxnaPYiUdO9e2G9UuNTBy5bwbChRRbAK8oOpXedD2LPxKccHmFo1fB9rFBbYWX6gCmY
        Hq1rrf8bG2GlRVmETXOQCheUcJ612tseX7CdikM3E7MA8KrqCXd8fuPrrIypZ2gqvbhN2C
        eCkmTyGMz620J61LzUNmCqxNJw0JV7Ln4DUFuB86Ns+Snbs2XnOGGo0zY1+vKi0etEufID
        CsVJ56ZScDehZzrwX2Ah+/kQs/h8SYYQCZ+36Y+Q34KlTpC+9wMmXK3Zj7UtoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603708041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+sNJyL5dbOwF5sddomoHWnKiwHRAinIMitE7aE0IfQ=;
        b=DZeXwicxt+HoMVxZrYgUHOOI3ImETw1I1+HVtS+eaZ3mSFb4pXQvz910rEbucEn1Qti+T0
        KoOAYmtZ/3Me9RDQ==
To:     Michael =?utf-8?Q?Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Michael =?utf-8?Q?Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: Re: [PATCH v4 0/3] time namespace aware system boot time
In-Reply-To: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 26 Oct 2020 11:27:21 +0100
Message-ID: <87h7qh4706.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19 2020 at 21:52, Michael Wei=C3=9F wrote:
> Michael Wei=C3=9F (3):
>   timens: additional helper functions for boottime offset handling
>   fs/proc: apply the time namespace offset to /proc/stat btime
>   selftests/timens: added selftest for /proc/stat btime
>
>  fs/proc/array.c                         |  6 ++-
>  fs/proc/stat.c                          |  3 ++
>  include/linux/time_namespace.h          | 22 ++++++++++
>  tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++-
>  4 files changed, 86 insertions(+), 3 deletions(-)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
