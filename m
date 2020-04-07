Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301651A04D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 04:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDGCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 22:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDGCYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:24:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CFB206C0;
        Tue,  7 Apr 2020 02:24:12 +0000 (UTC)
Date:   Mon, 6 Apr 2020 22:24:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     He Zhe <zhe.he@windriver.com>, tstoyanov@vmware.com,
        hewenliang4@huawei.com, linux-kernel@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v3] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200406222411.386ba51d@gandalf.local.home>
In-Reply-To: <20200325133551.GA19495@redhat.com>
References: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
        <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
        <20200325133551.GA19495@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 10:35:51 -0300
Arnaldo Carvalho de Melo <acme@redhat.com> wrote:

> Em Wed, Mar 25, 2020 at 09:05:46PM +0800, He Zhe escreveu:
> > Can this be considered for the moment?  
> 
> Rostedt, have you looked at this?
> 

Bah, I did but forgot to reply.

Yes, add my Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Sorry for not sending this out earlier.

-- Steve
