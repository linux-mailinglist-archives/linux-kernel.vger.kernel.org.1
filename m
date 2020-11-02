Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE52A24F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgKBHDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgKBHDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:03:31 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F457C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:03:31 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so13234409wrp.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:cc:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+Aqiym4GzKMgHshVO6JSUoZfk+nIQSE6aHVJe2K3jxE=;
        b=t2JXUNaGc/d+qMWWRQSEQwAfLWFc1ZdEKgkHkKOtlL5HXYSHcXxbhXu9VynZHb6ihm
         WXX+DAtp1aC2DrP2Mi/nnVF3WJT/q0a4HurVu86H/7cMYx3h0/I/ABqsQSWdCifGj5C1
         ve83OcGvXO7TQDSHzpnbFy8gaGNU0MRSfWuDBj3Iwia9TrQbJ6kuO4oEzvHUpXmho+rg
         71l2veRFOQDSPvuys/oz9/HyeZ27vkOr1ERBrCTtg3rsRJKM3eLndEGbCF5GS0YAFoRA
         6lXSEn4dIl33vqPDa8BdO0kH2q5bbepFsDEuoMLDrPL3jEfAMrbEgMhwhUKt2zA+QqKE
         RG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:cc:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+Aqiym4GzKMgHshVO6JSUoZfk+nIQSE6aHVJe2K3jxE=;
        b=ejSoHW3/UwnnXPIMHhzcbzw+SJPhBWDtm8qJRz9yC+ojUjaIIiiV1L4rknAOBTC+5g
         NzQTVJYQHD5NAYwAgVNhccDIBP5a+iILwwR1jNWhd2+lFXiD/zMfyC0HdZOWHzWKm1+3
         dQhq+IRiPvug4YkDOILbREMSHiwQTWn+aDpQmrzMzkaSgCNkY93yiNgnGigKlvRPtJqc
         Y1wVcIsp0F5KdwOfmJ5T723BXsktpvh23vafPxlSdoX5cEi0brPayXso36mqGstYLlPW
         gFmE0K/RXClUMcdy1qlvIJUyqea64Km3Jrmq8DtygtHpAX8I2GQnhJMg5TJQyfr+47eF
         3wxg==
X-Gm-Message-State: AOAM530MGEEpKYqjcHlgy85PZ+SxH7EHsGs5GekgyAlS/fQCR4uimU0Y
        vPRuvlrgmSFZxctDzx05E2O0nZGB588=
X-Google-Smtp-Source: ABdhPJwVJI/zbJU/B9iPWxfINsmRWjnxlBwVcHzfMzmwwqaoLisUmKZp84xtlXEG5mvYxkASxgMpRw==
X-Received: by 2002:adf:ea49:: with SMTP id j9mr18324311wrn.391.1604300610134;
        Sun, 01 Nov 2020 23:03:30 -0800 (PST)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id x7sm18311315wrt.78.2020.11.01.23.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 23:03:29 -0800 (PST)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.09 is released
Cc:     mtk.manpages@gmail.com
To:     lkml <linux-kernel@vger.kernel.org>
Message-ID: <83cfbc65-7524-5b26-11b3-6177b158c85d@gmail.com>
Date:   Mon, 2 Nov 2020 08:03:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.09 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from more than 40 people, with just over 500 commits making
changes to nearly 600 pages. Nine new pages have been added (six
of these are the result of splitting the rather unwieldy queue(3)
page into a number of small pieces). Special shout out to
Alejandro Colomar, who provided more than half (265!) of the commits.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.09

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2020/11/man-pages-509-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael


==================== Changes in man-pages-5.09 ====================

New and rewritten pages
-----------------------

system_data_types.7
    Alejandro Colomar, Michael Kerrisk
        A new page documenting a wide range of system data types.

kernel_lockdown.7
    David Howells, Heinrich Schuchardt  [Michael Kerrisk]
        New page documenting the Kernel Lockdown feature


Newly documented interfaces in existing pages
---------------------------------------------

fanotify_init.2
fanotify.7
    Amir Goldstein  [Jan Kara, Matthew Bobrowski]
        Document FAN_REPORT_DIR_FID

fanotify_init.2
fanotify.7
    Amir Goldstein  [Jan Kara, Matthew Bobrowski]
        Document FAN_REPORT_NAME

statx.2
    Ira Weiny
        Add STATX_ATTR_DAX

strerror.3
    Michael Kerrisk
        Document strerrorname_np() and strerrordesc_np()

strsignal.3
    Michael Kerrisk
        Document sigabbrev_np() and sigdescr_np().

loop.4
    Yang Xu
        Document LOOP_CONFIGURE ioctl
    Yang Xu
        Document LO_FLAGS_DIRECT_IO flag

capabilities.7
    Michael Kerrisk
        Document the CAP_CHECKPOINT_RESTORE capability added in Linux 5.9

ip.7
    Stephen Smalley  [Paul Moore]
        Document IP_PASSSEC for UDP sockets

ip.7
socket.7
    Stephen Smalley
        Document SO_PEERSEC for AF_INET sockets
    Sridhar Samudrala
        Document SO_INCOMING_NAPI_ID

socket.7
unix.7
    Stephen Smalley  [Serge Hallyn, Simon McVittie]
        Add initial description for SO_PEERSEC


Changes to individual pages
---------------------------

clone.2
    Michael Kerrisk
        CAP_CHECKPOINT_RESTORE can now be used to employ 'set_tid'

epoll_ctl.2
    Michael Kerrisk
        epoll instances can be nested to a maximum depth of 5
            This limit appears to be an off-by-one count against
            EP_MAX_NESTS (4).
perf_event_open.2
    Alexey Budankov
        Update the man page with CAP_PERFMON related information

seccomp.2
    Michael Kerrisk  [Jann Horn]
        Warn reader that SECCOMP_RET_TRACE can be overridden
            Highlight to the reader that if another filter returns a
            higher-precedence action value, then the ptracer will not
            be notified.
    Michael Kerrisk  [Rich Felker]
        Warn against the use of SECCOMP_RET_KILL_THREAD
            Killing a thread with SECCOMP_RET_KILL_THREAD is very likely
            to leave the rest of the process in a broken state.

dlopen.3
    Michael Kerrisk
        Clarify DT_RUNPATH/DT_RPATH details
            It is the DT_RUNPATH/DT_RPATH of the calling object (not the
            executable) that is relevant for the library search. Verified
            by experiment.

loop.4
    Yang Xu
        Add some details about lo_flags

proc.5
    Michael Kerrisk
        Update capability requirements for accessing /proc/[pid]/map_files
    Jann Horn  [Mark Mossberg]
        Document inaccurate RSS due to SPLIT_RSS_COUNTING
    Michael Kerrisk
        Note "open file description" as (better) synonym for "file handle"

bpf-helpers.7
    Michael Kerrisk  [Jakub Wilk]
        Resync with current kernel source

capabilities.7
    Michael Kerrisk
        Under CAP_SYS_ADMIN, group "sub-capabilities" together
            CAP_BPF, CAP_PERFMON, and CAP_CHECKPOINT_RESTORE have all been
            added to split out the power of CAP_SYS_ADMIN into weaker pieces.
            Group all of these capabilities together in the list under
            CAP_SYS_ADMIN, to make it clear that there is a pattern to these
            capabilities.

fanotify.7
fanotify_mark.2
    Amir Goldstein  [Jan Kara, Matthew Bobrowski]
        Generalize documentation of FAN_REPORT_FID

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
