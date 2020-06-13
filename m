Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F831F8506
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 21:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFMTyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 15:54:16 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:8813 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgFMTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:54:15 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sat, 13 Jun 2020 12:54:10 -0700
Received: from localhost (unknown [10.200.193.92])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6E658400BB;
        Sat, 13 Jun 2020 12:54:15 -0700 (PDT)
Date:   Sat, 13 Jun 2020 12:54:15 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dvyukov@google.com>, <elver@google.com>, <andreyknvl@google.com>,
        <mark.rutland@arm.com>, <rostedt@goodmis.org>,
        <jthierry@redhat.com>, <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 0/3] objtool: KCOV vs noinstr
Message-ID: <20200613195415.GC25598@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, dvyukov@google.com, elver@google.com,
        andreyknvl@google.com, mark.rutland@arm.com, rostedt@goodmis.org,
        jthierry@redhat.com, mbenes@suse.cz
References: <20200612143034.933422660@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200612143034.933422660@infradead.org>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 04:30:34PM +0200, Peter Zijlstra wrote:
> Hi All,
> 
> These patches go on top of objtool/core, although possibly we need them earlier.
> 
> In order to solve the KCOV-vs-noinstr situation, we need objtool to rewrite
> calls to __sanitizer_cov_*() into NOPs, similar to what recordmcount does.
> 
> I'm hoping the pending objtool-recordmcount patches can also reuse some of this.

This sounds great to me -- I'll have a look through your series and will try
rebasing my work on this.

Cheers,
    -Matt Helsley
