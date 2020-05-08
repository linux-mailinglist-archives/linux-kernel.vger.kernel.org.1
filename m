Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3684B1CB4F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEHQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 12:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEHQ1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:27:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C114208CA;
        Fri,  8 May 2020 16:27:05 +0000 (UTC)
Date:   Fri, 8 May 2020 12:27:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external
 modules
Message-ID: <20200508122703.6ee5cae0@gandalf.local.home>
In-Reply-To: <20200508160935.GB19436@zn.tnic>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com>
        <20200508104922.72565-3-vaibhav@linux.ibm.com>
        <20200508113100.GA19436@zn.tnic>
        <87blmy8wm8.fsf@linux.ibm.com>
        <20200508160935.GB19436@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 18:09:35 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 08, 2020 at 05:30:31PM +0530, Vaibhav Jain wrote:
> > I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
> > here.  
> 
> And what does "external" refer to? Because if it is out-of-tree, we
> don't export symbols for out-of-tree modules.

I've always wondered about this. Why not?

-- Steve
