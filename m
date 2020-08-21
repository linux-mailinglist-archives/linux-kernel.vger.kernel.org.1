Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5E24D229
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHUKWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 06:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgHUKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E11C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qB1PqWj8iEsFI4HuSCOaDFpePbWoleRB3VVW/9wDdqU=; b=pFdlZu43Oy1zabcl00DtplGi4s
        ajpHHmC/WhPgTYKwQOuodwctLDooj5rdzNI0hMxI9DHtgjXqS1dLmksQlissvdgQ0uPkRqNmCNBoj
        F/52Y6ionW9f/Ym7qM9AUJTqW6iZG0R1BMDS+mbRqkBOkvOCYjqmhOR7kGzKqeqDRDZ3oRlWJ3sm6
        baLwdFNNeQOvMmbR85G7jkriOe9p8zmrGp9p1t1CcF0rbIOm/SlJ0IeGRWjmC50C7oLRv56WElXgE
        ox03HW9KtG+xhDWNHOSws1AMPlfihCYJH5NTZEIq8JC9mruuCexlNDpJqJi2/+lDy8KzuNdgUM9JK
        sQ0ZOPtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94Ao-0003G7-0u; Fri, 21 Aug 2020 10:21:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68C9F3028C8;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4ECD62C8FF365; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821093912.815135402@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/8] x86/debug: Untangle handle_debug()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

handle_debug() is a mess, and now that we have separate user and kernel paths,
try and clean it up a bit.

Include's amluto's fix for convenience.

Since v1:

 - Changelogs!
 - fixed notifier order (Josh, Daniel)
 - tested kgdb


