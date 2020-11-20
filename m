Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245C72BB0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgKTQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:44:13 -0500
Received: from netrider.rowland.org ([192.131.102.5]:34519 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726426AbgKTQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:44:13 -0500
Received: (qmail 621340 invoked by uid 1000); 20 Nov 2020 11:44:12 -0500
Date:   Fri, 20 Nov 2020 11:44:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: Printk specifiers for __user pointers
Message-ID: <20201120164412.GD619708@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To the VSPRINTF maintainers:

Documentation/core-api/printk-formats.rst lists a large number of format 
specifiers for pointers of various sorts.  Yet as far as I can see, 
there is no specifier meant for use with __user pointers.

The security implications of printing the true, unmangled value of a 
__user pointer are minimal, since doing so does not leak any kernel 
information.  So %px would work, but tools like checkpatch.pl don't like 
it.

Should a new specifier be added?  If not, should we simply use %px?

Alan Stern
