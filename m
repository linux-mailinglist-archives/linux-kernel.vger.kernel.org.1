Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3C2BA227
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKTGKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKTGKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:10:13 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:10:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so6859271pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdwX15PjjgVYsGPQm3LPtIM44Dbam1YAqgtwWbypPNU=;
        b=JlIbAM9b7y1jPl2ghWpOrZr9k8qiFQL+8CYHzQHVNEkWbV85hITKHOEPxxcTDgGXf3
         qL13XlRk4lSAO3GAyIpSTG9rD6MFVQR4NJrmIQ5eYxS0I/mq39hZBg1X34wanlkWQU8k
         Tr9WAzEytwpL2YAYwUFiIrAv/qbhITL3oB9gT+l52Wr40HAhRYdbU38UZZaSgFBUBJLw
         JPCiZ0FT+TcQTFHB3/kzJyoQm/WvBEC7tPVXJedMWSsmGLLFVKSiGQHR4ze9FHTVc3HJ
         WSmUSn4f6x9cUxAM5RRXiuNozgrZtXub0nvPmvd+gnU3wyBeRpEMT6wOcCfXHFDk7Pz2
         YJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdwX15PjjgVYsGPQm3LPtIM44Dbam1YAqgtwWbypPNU=;
        b=TkMrauj4u2BXD/1ntEqgZNXR2Uqy99ENGybEnUzJY9yFxRrU7BNMr2XflPYG+2ages
         sZ9Tv3Jwux7BnbnLUEHfPoCKtG6F2ikpYqftz7znEX60JCh33GCwkoN8GG6z7rVOlvUE
         J/HoPL0R1LmG6uK1eyk6jZJIwCB3O67vntPbJhyczXEgvFkLRPX5Ljpf0F4LJpp5zjL+
         PzE7kt7E4E+f+pT8DLovzT5+JQVkfhbZHLAOLLcJLkSnF8v9SDeTSBPAqOwPyeohxul5
         jurkS1ami1Utt2qtOjmezzyJ56a0DYCC6OmmwbR7ncJlthmehNcrufQQAt8z+Il1ZGDB
         vWbQ==
X-Gm-Message-State: AOAM533xv3TEQD5sOHjwX9vERe5wHiDsw5jqsEi6D9rQMUDTE5fQCp/2
        cTu1qsfXtjFSiG8OWVAyONeB
X-Google-Smtp-Source: ABdhPJylTVxL28fiCN+KSnCJ0hE3wYgDgjQGVt1yn8FedkL3nZ+KTCFmcRB2pc/uB6oAitBmkk4TTg==
X-Received: by 2002:a17:90b:100f:: with SMTP id gm15mr7833192pjb.63.1605852611302;
        Thu, 19 Nov 2020 22:10:11 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 22sm2031747pjb.40.2020.11.19.22.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 22:10:10 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:40:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, loic.poulain@linaro.org,
        netdev@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v12 5/5] selftest: mhi: Add support to test MHI LOOPBACK
 channel
Message-ID: <20201120061003.GA3909@work>
References: <1605566782-38013-1-git-send-email-hemantk@codeaurora.org>
 <1605566782-38013-6-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605566782-38013-6-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:46:22PM -0800, Hemant Kumar wrote:
> Loopback test opens the MHI device file node and writes
> a data buffer to it. MHI UCI kernel space driver copies
> the data and sends it to MHI uplink (Tx) LOOPBACK channel.
> MHI device loops back the same data to MHI downlink (Rx)
> LOOPBACK channel. This data is read by test application
> and compared against the data sent. Test passes if data
> buffer matches between Tx and Rx. Test application performs
> open(), poll(), write(), read() and close() file operations.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>

One nitpick below, with that addressed:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  Documentation/mhi/uci.rst                          |  32 +
>  tools/testing/selftests/Makefile                   |   1 +
>  tools/testing/selftests/drivers/.gitignore         |   1 +
>  tools/testing/selftests/drivers/mhi/Makefile       |   8 +
>  tools/testing/selftests/drivers/mhi/config         |   2 +
>  .../testing/selftests/drivers/mhi/loopback_test.c  | 802 +++++++++++++++++++++
>  6 files changed, 846 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/mhi/Makefile
>  create mode 100644 tools/testing/selftests/drivers/mhi/config
>  create mode 100644 tools/testing/selftests/drivers/mhi/loopback_test.c
> 
> diff --git a/Documentation/mhi/uci.rst b/Documentation/mhi/uci.rst
> index ce8740e..0a04afe 100644
> --- a/Documentation/mhi/uci.rst
> +++ b/Documentation/mhi/uci.rst
> @@ -79,6 +79,38 @@ MHI client driver performs read operation, same data gets looped back to MHI
>  host using LOOPBACK channel 1. LOOPBACK channel is used to verify data path
>  and data integrity between MHI Host and MHI device.
>  
> +Loopback Test
> +~~~~~~~~~~~~~
> +
> +Loopback test application is used to verify data integrity between MHI host and
> +MHI device over LOOPBACK channel. This also confirms that basic MHI data path
> +is working properly. Test performs write() to send tx buffer to MHI device file
> +node for LOOPBACK uplink channel. MHI LOOPBACK downlink channel loops back
> +transmit data to MHI Host. Test application receives data in receive buffer as
> +part of read(). It verifies if tx buffer matches rx buffer. Test application
> +performs poll() before making write() and read() system calls. Test passes if
> +match is found.
> +
> +Test is present under tools/testing/selftests/drivers/mhi. It is compiled using
> +following command in same dir:-
> +
> +make loopback_test
> +
> +Test is run using following command arguments:-
> +
> +loopback_test -c <device_node> -b <transmit buffer size> -l <log level> -i
> +<number of iterations>
> +
> +Required argument:
> +-c : loopback chardev node
> +
> +Optional argument:
> +-b : transmit buffer size. If not present 1024 bytes size transmit buffer
> +     is sent.
> +-i : Number of iterations to perform, If not present only one transmit buffer
> +     is sent.
> +-l : Log level. If not present defaults to DBG_LVL_INFO.
> +
>  Other Use Cases
>  ---------------
>  
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d9c2835..084bc1e 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -10,6 +10,7 @@ TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
>  TARGETS += drivers/dma-buf
> +TARGETS += drivers/mhi
>  TARGETS += efivarfs
>  TARGETS += exec
>  TARGETS += filesystems
> diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> index ca74f2e..e4806d5 100644
> --- a/tools/testing/selftests/drivers/.gitignore
> +++ b/tools/testing/selftests/drivers/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /dma-buf/udmabuf
> +/mhi/loopback_test
> diff --git a/tools/testing/selftests/drivers/mhi/Makefile b/tools/testing/selftests/drivers/mhi/Makefile
> new file mode 100644
> index 0000000..c06c925
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/mhi/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +CFLAGS += -I../../../../../usr/include/ -g -Wall
> +
> +LDLIBS = -lpthread
> +TEST_GEN_PROGS := loopback_test
> +
> +include ../../lib.mk
> +
> diff --git a/tools/testing/selftests/drivers/mhi/config b/tools/testing/selftests/drivers/mhi/config
> new file mode 100644
> index 0000000..471dc92
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/mhi/config
> @@ -0,0 +1,2 @@
> +CONFIG_MHI_BUS=y
> +CONFIG_MHi_UCI=y
> diff --git a/tools/testing/selftests/drivers/mhi/loopback_test.c b/tools/testing/selftests/drivers/mhi/loopback_test.c
> new file mode 100644
> index 0000000..99b7712
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/mhi/loopback_test.c
> @@ -0,0 +1,802 @@
> +

[...]

> +int main(int argc, char *argv[])
> +{
> +	int ret = 0;
> +
> +	loopback_test_set_defaults();
> +	test_log(DBG_LVL_INFO, "MHI Loopback test App\n");
> +
> +	if (argc > 1)
> +		ret = loopback_test_parse(argc, argv);

Effectively this functions does parse and run, so this should be called
as, "loopback_test_parse_run" or pthread creation should be moved here.

Thanks,
Mani

> +	else
> +		usage();
> +
> +	return ret;
> +}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
