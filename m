Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E131CB29C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 11:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgEHPOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:14:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCA620736;
        Fri,  8 May 2020 15:14:50 +0000 (UTC)
Date:   Fri, 8 May 2020 11:14:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200508111449.575d176c@gandalf.local.home>
In-Reply-To: <20200508144527.GR1992@kadam>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
        <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
        <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
        <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
        <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
        <20200508090053.430d28d7@gandalf.local.home>
        <20200508144527.GR1992@kadam>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 17:45:27 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> > Yunfeng, your v2 was fine and has already landed in Linus's tree. Feel free
> > to ignore Markus's suggestions in the future.  
> 
> There was actually a bug in v2.  It exits with a non-zero instead of
> zero on success so it will mess up people's scripts.

Thanks, I just fixed it. And because of the distraction of Markus's
bikesheding, it was missed :-(

-- Steve
