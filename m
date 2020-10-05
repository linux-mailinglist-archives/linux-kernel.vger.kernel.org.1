Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C28310E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJEHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgJEHoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:44:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC96C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:44:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id p21so5522970pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X23br66JlsI+U5TsUplHSaOteTplJYGMMbIqIW0LyRE=;
        b=X0wMWPpuEYm+0K8Cy3ECdBTavARN3sHHi+Krskk0qghxKsdvff7Ppo31h7Nkm1Yf/C
         TCGkThy/lWuZ1Vaeuijj4FGNl4/cQJ0gufGWcNPlHUGUQokXCgxXSuYHBlv4DXWZm2hE
         J40qNxV0S2gRhqBnE9RNTlOaaXukK1ZSeiFXPPhybK+JMfFV+XpAqoxvG9mal2f2YRpx
         9ZvWsGeH+kna/vtlcubeG9G6N2JKJJYixvf/DKqq/qnhAqdw1KqhJnHRi1Na9T/Hd93+
         /ZpgbNGEbIejFo+8TkkyWGyHE/2LkQ9kGetqxDl7S/z++OWq6YkHW5ildHIqrh5qBkOF
         hrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X23br66JlsI+U5TsUplHSaOteTplJYGMMbIqIW0LyRE=;
        b=o8TCodLQbs3RDWBKkvXuYK/WKdV1/hhZOcEw1zzGT29Mwrvf4I9jGIKSQzGvQCfbMk
         4rH9/8/itzseuhzzzisgRqRqqiL2mYwoWB7vHNjNGTaaRyoDbg/pnHheRKYOvWRG1inr
         I74nd395vDEawqPzoDZKcd6igRwbXgLiWEUJ2U9NFmg3piVZiu1WPKvfBGdMmPLT+hN6
         b9QcF5MGOOPfUuri9lSdyrbQ4XgyKnYrYu3Co3rR1rYZ+HW9mKmgsOyA8XDCCmETcMjq
         9n+s2U3DUlH+ukhlEzkKjO3ZHTraVR3NINHwMQX6bHQiD/9hVqok5DDSLB5qENt/mBxd
         0nrQ==
X-Gm-Message-State: AOAM533My8+acU2jnm2VPQPsmpRE5E6jTODq18BKBGaGKHbe3j/CkbZS
        QLGlP+Dq7L4QN2a2vZMcwyt4dQ==
X-Google-Smtp-Source: ABdhPJxjiBhE05FbFRoagaOdnJMPR0JknN8uuakg4QEBAotLL4GrrLTqGoZh+gRIMoJ98GLs8SgnlQ==
X-Received: by 2002:a17:90a:a58d:: with SMTP id b13mr15569298pjq.196.1601883840413;
        Mon, 05 Oct 2020 00:44:00 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id e8sm9754948pgj.8.2020.10.05.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:43:59 -0700 (PDT)
Date:   Mon, 5 Oct 2020 07:43:56 +0000
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] add support for metadata encryption to F2FS
Message-ID: <20201005074356.GA1961565@google.com>
References: <20201005073606.1949772-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005073606.1949772-1-satyat@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 07:36:03AM +0000, Satya Tangirala wrote:
> This patch series adds support for metadata encryption to F2FS using
> blk-crypto.
> 
> Patch 1 replaces fscrypt_get_devices (which took an array of request_queues
> and filled it up) with fscrypt_get_device, which takes a index of the
> desired device and returns the device at that index (so the index passed
> to fscrypt_get_device must be between 0 and (fscrypt_get_num_devices() - 1)
> inclusive). This allows callers to avoid having to allocate an array to
> pass to fscrypt_get_devices() when they only need to iterate through
> each element in the array (and have no use for the array itself).
> 
> Patch 2 introduces some functions to fscrypt that help filesystems perform
> metadata encryption. Any filesystem that wants to use metadata encryption
> can call fscrypt_setup_metadata_encryption() with the super_block of the
> filesystem, the encryption algorithm and the descriptor of the encryption
> key. The descriptor is looked up in the logon keyring of the current
> session with "fscrypt:" as the prefix of the descriptor.
> 
> The patch also introduces fscrypt_metadata_crypt_bio() which an FS should
> call on a bio that the FS wants metadata crypted. The function will add
> an encryption context with the metadata encryption key set up by the call
> to the above mentioned fscrypt_setup_metadata_encryption().
> 
> The patch also introduces fscrypt_metadata_crypt_prepare_all_devices().
> Filesystems that use multiple devices should call this function once all
> the underlying devices have been determined. An FS might only be able to
> determine all the underlying devices after some initial processing that
> might already require metadata en/decryption, which is why this function
> is separate from fscrypt_setup_metadata_encryption().
> 
> Patch 3 wires up F2FS with the functions introduced in Patch 2. F2FS
> will encrypt every block (that's not being encrypted by some other
> encryption key, e.g. a per-file key) with the metadata encryption key
> except the superblock (and the redundant copy of the superblock). The DUN
> of a block is the offset of the block from the start of the F2FS
> filesystem.
> 
> Please refer to the commit message for why the superblock was excluded from
> en/decryption, and other limitations. The superblock and its copy are
> stored in plaintext on disk. The encryption algorithm used for metadata
> encryption is stored within the superblock itself. Changes to the userspace
> tools (that are required to test out metadata encryption with F2FS) are
> also being sent out - I'll post a link as a reply to this mail once it's
> out.
The userspace patches are at

https://lore.kernel.org/linux-fscrypt/20201005074133.1958633-2-satyat@google.com/

> 
> Satya Tangirala (3):
>   fscrypt, f2fs: replace fscrypt_get_devices with fscrypt_get_device
>   fscrypt: Add metadata encryption support
>   f2fs: Add metadata encryption support
> 
>  Documentation/filesystems/f2fs.rst |  12 ++
>  fs/crypto/Kconfig                  |   6 +
>  fs/crypto/Makefile                 |   1 +
>  fs/crypto/fscrypt_private.h        |  19 +++
>  fs/crypto/inline_crypt.c           |  37 +----
>  fs/crypto/metadata_crypt.c         | 220 +++++++++++++++++++++++++++++
>  fs/f2fs/data.c                     |  24 ++--
>  fs/f2fs/f2fs.h                     |   2 +
>  fs/f2fs/super.c                    |  83 +++++++++--
>  include/linux/f2fs_fs.h            |   3 +-
>  include/linux/fs.h                 |   3 +
>  include/linux/fscrypt.h            |  51 ++++++-
>  12 files changed, 410 insertions(+), 51 deletions(-)
>  create mode 100644 fs/crypto/metadata_crypt.c
> 
> -- 
> 2.28.0.806.g8561365e88-goog
> 
