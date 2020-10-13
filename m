Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CD828C71E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgJMC17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgJMC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:27:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C5FC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0T3asWHfqUWz0zED1P6OmUdTOLJk2ixaklQ7SuPi8Uc=; b=W2otGeGilNTb+3EnbAVR4yGnzD
        09fF9YkPwWDnEmU53QuASiGFLJJDQoyUv+mPN8d9BePXHZI7wg7FVdTPzMVUe/iPA6nf3Cvo0hUr7
        IFAyx9rfusnQAw/Oa7zkosjTemjcSI4+hI8FAdZVNQotH8+CasvFgAYsBhF9wTIa2QxFcfnoNfhqD
        W9s65jYyot111qbyaTVaAVoJrvO6hTXu+42eng/IV4F85AncBm5ec0LYEIcid6/dSKhC57hEgyvlP
        tmktxHEp469oqAT6BsnRyTNyVYSPa6+u3m+mhjtYc+VV29ylezZcy7/A18HsEVMyrRchuv/jUXUwl
        VHTJ68EQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSA2c-0005Sn-D0; Tue, 13 Oct 2020 02:27:55 +0000
Subject: Re: [PATCH 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20201013022429.454161-1-daeho43@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55a72698-014a-da39-e573-a8e9e9b52ce6@infradead.org>
Date:   Mon, 12 Oct 2020 19:27:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013022429.454161-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 7:24 PM, Daeho Jeong wrote:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 53fe2853579c..a33c90cf979b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -433,6 +433,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
>  #define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
>  						struct f2fs_sectrim_range)
> +#define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
> +						struct f2fs_comp_option)

Hi,

F2FS_IOCTL_MAGIC should be listed in
Documentation/userspace-api/ioctl/ioctl-number.rst.

Please add it there.

thanks.
-- 
~Randy

