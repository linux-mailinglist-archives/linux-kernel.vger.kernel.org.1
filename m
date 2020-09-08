Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF4261611
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgIHRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 13:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbgIHQUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from [192.168.0.108] (unknown [117.89.211.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D92229C9;
        Tue,  8 Sep 2020 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577154;
        bh=qu/VD/1ayytWRjDRyQndb7jEuf1+9w8WPZlWAXNLxKE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=faOgOH+DcFRZTm9HX6sKgDwiXJ3s8Y7cBZ5xeg8L6BgMvwDSYWJZIOdxTW51IMTM9
         6nYU5Hcq+kQvO3dhQZF6lPbmWvjvXcgoZ3OYk18oRrKIIGe1nTqvXvCw3fxIMFQ7Wj
         DOy+QPrp4AuiAsuVNXd7MPNHUxOPHb5QDrCkkf08=
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: change return value of
 f2fs_disable_compressed_file to bool
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200908024411.2692388-1-daeho43@gmail.com>
 <20200908024411.2692388-2-daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <590f0fe7-a4f2-9939-fbb2-35f52179135b@kernel.org>
Date:   Tue, 8 Sep 2020 22:59:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200908024411.2692388-2-daeho43@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-9-8 10:44, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> The returned integer is not required anywhere. So we need to change
> the return value to bool type.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
