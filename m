Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5811B9730
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 08:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgD0GRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 02:17:49 -0400
Received: from verein.lst.de ([213.95.11.211]:45641 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgD0GRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:17:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A844168CEE; Mon, 27 Apr 2020 08:17:46 +0200 (CEST)
Date:   Mon, 27 Apr 2020 08:17:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] configfs: Fix config_item refcnt leak in
 configfs_rmdir()
Message-ID: <20200427061746.GA16674@lst.de>
References: <1587819146-38856-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587819146-38856-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the configfs tree.
