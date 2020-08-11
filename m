Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD1241F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKSMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 14:12:46 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53401 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:12:44 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C79A1C0006;
        Tue, 11 Aug 2020 18:12:39 +0000 (UTC)
Date:   Tue, 11 Aug 2020 11:12:36 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Subject: pidfd and O_NONBLOCK
Message-ID: <20200811181236.GA18763@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, O_NONBLOCK has no effect on a pidfd. When calling
waitid on a pidfd for a running process, it always blocks unless you
provide WNOHANG.

I don't think anything depends on that behavior. Would it be possible to
make O_NONBLOCK on a pidfd cause waitid on a running process to return
EWOULDBLOCK?

This would make it easier to use pidfd in some non-blocking event loops.

- Josh Triplett
