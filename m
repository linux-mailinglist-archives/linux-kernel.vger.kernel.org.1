Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CA26CB40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgIPUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgIPR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:27:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E538EC0A8889
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:41:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so6691883wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3G5QEGbkKNJ30+kU6LXaoDvAPXSs+sgtSj04KcPMQDA=;
        b=Sm6cIcfQdXNR/nF1M6QBVB85DcM267KkHeDIh+C55CN2GI/VpjGh5/9vYV+w6/PO8p
         hM4qeeJULScCVDGUTv6S+LM86m4JI962GHTZSRSTfmXtntkwvK3VcOLh37+ttAfjB1oX
         RuTgcNg2yzaOnoCOLFRNWtA09LNIyiaL1rWuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3G5QEGbkKNJ30+kU6LXaoDvAPXSs+sgtSj04KcPMQDA=;
        b=toET+B1UDV/kXwgdCitRJcq38wD7kAeIIL1lKQx0yc2Af58n4OX/ISfRjMWd/tviHV
         V+64qtezTHAMREgvnv1OkYcho2u0/Pozt/ODdLH/qCZZIoGrNjuNP6keORQZP/NLHF0w
         /kS1xSpDmPzeBTm/7fJlxcqVa35u0jZ1kv2Bb7loMmuq9SLwZksWQAGD9Tk6/a8UZFY2
         y014FthJYD5Tj9yK1LHeU03u0BgAyTK+nghhasmbGcVrxTIAFgF9diab1/kz40OBelbF
         XwXv3OEbEdMPfSEW1eagnAqRkAioTQsPi2LAN8+hXClMH3cxdyEkeS0By+ZVTk85VPlO
         Gl1A==
X-Gm-Message-State: AOAM533+XopNGMn0hzPjIIwQTRHpcy04a/ocy82OZJBEyHzzBurBpU5y
        HeKyv1CxQuiBjj1dKEXDfer/Ow==
X-Google-Smtp-Source: ABdhPJxq1vh9EO0rpXrBaT8rs4odd+BzkhQ3bZnhitc/G/USx0mz2PsAuVGR9PiugesL21jUx6GiFA==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr26627057wrs.293.1600260095569;
        Wed, 16 Sep 2020 05:41:35 -0700 (PDT)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id v17sm32719109wrr.60.2020.09.16.05.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:41:34 -0700 (PDT)
Message-ID: <5ab256148e8ad5f9882e888dac809bc72cd3fe66.camel@chromium.org>
Subject: Re: [PATCH] ima: Fix NULL pointer dereference in ima_file_hash
From:   Florent Revest <revest@chromium.org>
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Date:   Wed, 16 Sep 2020 14:41:33 +0200
In-Reply-To: <20200916120548.364892-1-kpsingh@chromium.org>
References: <20200916120548.364892-1-kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Florent Revest <revest@chromium.org>

On Wed, 2020-09-16 at 12:05 +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> ima_file_hash can be called when there is no iint->ima_hash available
> even though the inode exists in the integrity cache.
> 
> An example where this can happen (suggested by Jann Horn):
> 
> Process A does:
> 
> 	while(1) {
> 		unlink("/tmp/imafoo");
> 		fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
> 		if (fd == -1) {
> 			perror("open");
> 			continue;
> 		}
> 		write(fd, "A", 1);
> 		close(fd);
> 	}
> 
> and Process B does:
> 
> 	while (1) {
> 		int fd = open("/tmp/imafoo", O_RDONLY);
> 		if (fd == -1)
> 			continue;
>     		char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
> 			 	     MAP_PRIVATE, fd, 0);
> 		if (mapping != MAP_FAILED)
> 			munmap(mapping, 0x1000);
> 		close(fd);
>   	}
> 
> Due to the race to get the iint->mutex between ima_file_hash and
> process_measurement iint->ima_hash could still be NULL.
> 
> Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash
> of a given file")
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  security/integrity/ima/ima_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 8a91711ca79b..4c86cd4eece0 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf,
> size_t buf_size)
>  		return -EOPNOTSUPP;
>  
>  	mutex_lock(&iint->mutex);
> +
> +	/*
> +	 * ima_file_hash can be called when ima_collect_measurement has
> still
> +	 * not been called, we might not always have a hash.
> +	 */
> +	if (!iint->ima_hash) {
> +		mutex_unlock(&iint->mutex);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (buf) {
>  		size_t copied_size;
>  

