Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC163298A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769755AbgJZK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:28:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768430AbgJZK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:28:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603708117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5fTWk6slj+E7imkK9HrK7ftFSS9/gEK4mhZa60fVww=;
        b=a59eYWCjVaoI70IOQEnbNuzuWBVg+sv/beJmPWWVAZoa7wTcySRitCjwTg8UDoCOtLLljk
        4LOVX1/a5bgJc0LAdJr8FwZrsnCJ1LF2EoyRl1pIaTBUTG2kcfLEOZ5nwr0BO6++sDnPFR
        JxFoC0CPIJ7dBZI/cTDiB7RH+xPYl5XoAKOauL6gs/USy2ZXPwnX0wn6H0dzk7MVPlqDrN
        P10oyZjMBUg0WPBxiYc2cyzNxSQbCPH0Vmx2A8lzbzG4A6G81R5qoqhOjkJrAPn1Q+cNxC
        acY+xgZF9A7PxwhUXC819G4r7vHduvm2GjMj3dZqLi6hxGd/t8IZZcxM8VH5gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603708117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5fTWk6slj+E7imkK9HrK7ftFSS9/gEK4mhZa60fVww=;
        b=7HGCcKJw8egDLGjooY9uyvL/oAjzh0Cg+iV5QgyFo4Ggn9x20kUVnvK0CPmUtkpxcoZ49w
        C+sQtg7wAE42b3Bg==
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
Subject: Re: [PATCH v4 2/3] fs/proc: apply the time namespace offset to /proc/stat btime
In-Reply-To: <20201019195257.10728-3-michael.weiss@aisec.fraunhofer.de>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de> <20201019195257.10728-3-michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 26 Oct 2020 11:28:37 +0100
Message-ID: <87eell46y2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19 2020 at 21:52, Michael Wei=C3=9F wrote:

> '/proc/stat' provides the field 'btime' which states the time stamp of
> system boot in seconds. In case of time namespaces, the offset to the
> boot time stamp was not applied earlier. However, in container
> runtimes which utilize time namespaces to virtualize boottime of a
> container, this leaks information about the host system boot time.

Not sure if that qualifies as a leak. The point is that it confuses the
tasks which are in a different time universe.

Thanks,

        tglx
