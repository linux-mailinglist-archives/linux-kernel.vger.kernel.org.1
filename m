Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2020202BEB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 19:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgFUR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 13:56:39 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38404 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbgFUR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 13:56:39 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 13:56:38 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 222D515F925;
        Mon, 22 Jun 2020 02:50:46 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05LHoiS3305894
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 02:50:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05LHoiV51124458
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 02:50:44 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 05LHoiZ21124457;
        Mon, 22 Jun 2020 02:50:44 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     trix@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: add a check to fat_add_new_entries
References: <20200616162922.26168-1-trix@redhat.com>
Date:   Mon, 22 Jun 2020 02:50:44 +0900
In-Reply-To: <20200616162922.26168-1-trix@redhat.com> (trix@redhat.com's
        message of "Tue, 16 Jun 2020 09:29:22 -0700")
Message-ID: <871rm8b957.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trix@redhat.com writes:

>  		start_blknr = blknr = fat_clus_to_blknr(sbi, cluster[i]);
>  		last_blknr = start_blknr + sbi->sec_per_clus;
> +
> +		/* overflow */
> +		if (unlikely(last_blknr <= start_blknr)) {
> +			err = -ENOMEM;
> +			goto error_nomem;
> +		}
> +

The cluster is 28bits and sec_per_clus is 8bits, so this should never
overflow actually. Is there no way to tell it to clang?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
