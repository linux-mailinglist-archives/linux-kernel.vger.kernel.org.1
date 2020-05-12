Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C311CF1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgELJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 05:45:25 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:48870 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgELJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:45:25 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 2577B1A40053; Tue, 12 May 2020 02:45:24 -0700 (PDT)
Date:   Tue, 12 May 2020 02:45:24 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Question regarding blocking set[ug]id on processes including via
 suid executables
Message-ID: <20200512094524.662gnls64rwjhct2@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I'm curious if someone knows a way to do this using existing linux
interfaces.

I'd like to create a login lacking the ability to switch uid/gid.

Even if the process has access to suid executables like /bin/su, and
the user has the root password, I'd like the descendant processes of
their login to be simply incapable of changing uid/gid, even when it's
in the form of running a program w/suid bit set on an existing and
accessible executable in the filesystem.  No matter what, it just
can't happen.

Do we have any such thing today?  I'd really like to be able to set
this on a specific user and all logins of that user are simply stuck
on that uid no matter what.

Thanks in advance,
Vito Caputo
