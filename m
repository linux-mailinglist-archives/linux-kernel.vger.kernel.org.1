Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF402AB378
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgKIJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:22:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgKIJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:22:34 -0500
Date:   Mon, 9 Nov 2020 10:22:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604913752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/k9bu8aY4YayliQx/1Nf8otJxc4JcbbCTKtVyXu6KXU=;
        b=GTMHDDdeM3m9ZyISyJL3GxPBkXT6OQ/19XrYUsNWljySv0ywBT+ogFyPa7URoqLNqxwsFN
        uNmKBBIlhG5l/sTFZZr2pMdIBmhIthjE6My54puWYRsfI5JwmbQCc7UQQOpm5HO6x0cZpg
        SyaK/1GTYZCxqCvrU8HaFG0g2MIpScITnnEK5yq0NPPBE7kPp9TCCpJbW3SPU1ibpEem58
        g3kuO04IFJBNVsykkDnn4RJNWunCpB7+YpVJLcoml2iNzyQLM8CZtvz8HNoLkqRFStuqKj
        uZFvtkuMrp3+9i4FuVbKmnQvguAcpq1wCb2+qJ/UWWaBxcUDLITiXmwINdHagA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604913752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/k9bu8aY4YayliQx/1Nf8otJxc4JcbbCTKtVyXu6KXU=;
        b=upIiY4AaMpGRp7haGPJE9AW/u0vlDDQ4S3awLpYYkU0x06/gL8SwB4pjKU+9EchBTk/qh0
        yDUVPs4xMYIklaAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 2/6] tcp: Remove superfluous BH-disable around
 listening_hash
Message-ID: <20201109092231.3t2pawkvv7dxasfs@linutronix.de>
References: <20201107020636.598338441@goodmis.org>
 <20201107020727.806739147@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107020727.806739147@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06 21:06:38 [-0500], Steven Rostedt wrote:
> 5.4.74-rt42-rc1 stable review patch.
> If anyone has any objections, please let me know.

Please drop that one. Lockep complains on RT with newer softirq code.
Older RT and mainline does not complain here unless it observes
inet_listen_hashbucket::lock in serving-softirq context (which is not
the case).

Sebastian
