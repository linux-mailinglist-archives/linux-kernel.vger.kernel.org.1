Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7F284B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgJFMNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgJFMNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:13:52 -0400
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4760E20663;
        Tue,  6 Oct 2020 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601986431;
        bh=5N1sB0RTYC4S5uCLZ5Ub0O/RMBumfJWMKP5+urqBL+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZbOSVj459Jb21PThxbVW5rGNSnI5aMlk5GCNTghfKjj/ULAIk1AAB3G+9pEtSmQYe
         oo8G51N1ddfo2J2LgYuappfgeYfnDU+DSP4JX67x0yYCKTyD6XCR487Avzz5pNBEHy
         N7dR0z4dBokJQKxRhY/0xw2j6QFo0+RpO8u0fSJw=
Date:   Tue, 6 Oct 2020 14:13:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox" <willy@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] script: add a script for checking doc problems with
 external functions
Message-ID: <20201006141346.68074cff@coco.lan>
In-Reply-To: <e40a32900dba6b8e7a1f41838ee8caeb1ef1c1b3.1601985151.git.mchehab+huawei@kernel.org>
References: <20201005125920.27a7768d@coco.lan>
        <e40a32900dba6b8e7a1f41838ee8caeb1ef1c1b3.1601985151.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew/Jon,

Em Tue,  6 Oct 2020 13:53:34 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> While not all EXPORT_SYMBOL*() symbols should be documented,
> it seems useful to have a tool which would help to check what
> symbols aren't documented.
> 
> This is a first step on this direction. The tool has some
> limitations. Yet, it could be useful for maintainers to check
> about missing documents on their subsystems.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As suggested, I improved the script for it to provide some hints
about what documentation is missing:

	$ ./scripts/check_docs_external_symbols drivers/media/v4l2-core/
	warning: drivers/media/v4l2-core/videobuf-dma-contig.c: missing documentation for videobuf_queue_dma_contig_init videobuf_to_dma_contig videobuf_dma_contig_free
	warning: drivers/media/v4l2-core/v4l2-clk.c: missing documentation for v4l2_clk_get v4l2_clk_put v4l2_clk_enable v4l2_clk_disable v4l2_clk_get_rate v4l2_clk_set_rate	v4l2_clk_register v4l2_clk_unregister __v4l2_clk_register_fixed v4l2_clk_unregister_fixed
	warning: include/media/v4l2-h264.h: file not included at Documentation/
	warning: drivers/media/v4l2-core/v4l2-h264.c: file not included at Documentation/
	warning: drivers/media/v4l2-core/videobuf-core.c: missing documentation for videobuf_alloc_vb videobuf_waiton videobuf_iolock videobuf_queue_to_vaddr videobuf_queue_core_init videobuf_queue_is_busy videobuf_queue_cancel videobuf_next_field videobuf_mmap_free __videobuf_mmap_setup videobuf_mmap_setup videobuf_reqbufs videobuf_querybuf videobuf_qbuf videobuf_dqbuf videobuf_streamon videobuf_streamoff videobuf_read_one videobuf_read_start videobuf_read_stop videobuf_stop videobuf_read_stream videobuf_poll_stream videobuf_mmap_mapper
	warning: drivers/media/v4l2-core/v4l2-mem2mem.c: file not included at Documentation/
	warning: drivers/media/v4l2-core/v4l2-dev.c: missing documentation for video_device_alloc video_device_release video_device_release_empty video_devdata v4l2_prio_init v4l2_prio_change v4l2_prio_open v4l2_prio_close v4l2_prio_max v4l2_prio_check __video_register_device
	warning: drivers/media/v4l2-core/v4l2-dev.c: file not included at Documentation/

It also report things that shouldn't be documented, like those:

	$ ./scripts/check_docs_external_symbols drivers/media/pci/saa7134
	warning: drivers/media/pci/saa7134/saa7134-video.c: missing documentation for saa7134_vb2_buffer_queue saa7134_enum_input saa7134_g_input saa7134_s_input saa7134_querycap saa7134_s_std saa7134_g_std saa7134_querystd saa7134_g_tuner saa7134_s_tuner saa7134_g_frequency saa7134_s_frequency
	warning: drivers/media/pci/saa7134/saa7134-core.c: missing documentation for saa7134_stop_streaming saa7134_ts_register saa7134_ts_unregister saa7134_set_gpio saa7134_dmasound_init saa7134_dmasound_exit saa7134_pgtable_free saa7134_pgtable_build saa7134_pgtable_alloc saa7134_set_dmabits
	warning: drivers/media/pci/saa7134/saa7134-ts.c: missing documentation for saa7134_ts_buffer_init saa7134_ts_buffer_prepare saa7134_ts_queue_setup saa7134_ts_start_streaming saa7134_ts_stop_streaming

On this specific case, the saa7134 driver was split into multiple
drivers, depending on the PCI sub-interfaces found on some complex
media devices. IMO, it doesn't make any sense to document such
symbols, as they aren't meant to be used outside saa7134 sub-drivers.

-

As noticed on its comments, this script is not perfect. It tries to
avoid reporting false-positives by not processing files that it
can't find all includes and by skipping non-functions.

Yet, it can take a long time for it to parse the entire Kernel
tree. So, at least on its current state, I don't think it would
be a good idea to add it to the default build.

Feel free to either take it as-is, to improve it, or to ignore ;-)

Thanks,
Mauro
