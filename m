Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF35C1A926D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 07:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393275AbgDOFYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 01:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389365AbgDOFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:24:45 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8454BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:24:43 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id r7so1508428vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jgottula-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CjsNluhDo6fii/3wuLR0y0/drIzNQWBRrY6KxvovKTQ=;
        b=jDnPnIgi7FFitiIZ8LbcTGZwv9agTPLMLv2ivenUIbh5qdeAbnOQwcSdYlcK41IrGL
         /sUcePO+BF/BiiWpgdjxBHB0NHiqtFuTtRo2EPBN7eh7iBxtSffRUr1/igweyng3ffhn
         +GqPqMKKV0S48gRa2B/h6fFWtGhb5cFrUpKlD+Re1OkUEwocS8u7VBovDftc/0vCfC9g
         L7SYN2MMIKb0go4htOsrNbXHfS6H3QeEH8FEaFlie9s2YfHqkwJquuTf6SBL+Rq/zJFK
         148j0XmJh6nypq7hsQNHk8H1wEb9XtuiokbeZaAE3WABugYFNvtMI9ajTSP4VRYQpRa1
         ADbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CjsNluhDo6fii/3wuLR0y0/drIzNQWBRrY6KxvovKTQ=;
        b=ep70e1zN+1ORytQURBV45gsxQcvxIBarhjc0ShuhDlba03XOxjFB+Z79sUqIvXga71
         et82iv9g830PZDphenvTO+2TFjGZRNuPiQ0r1ZbZPLWVCds8kJp1Q9xBuU9amsOh/mqn
         UXMa6myAp0wQOwfugvPz+pPThr/h3LqeGoD1QzRh6hrXzGnnnx712a8Z609cKmnG50wt
         78/8jS9itp+awQKJT8O+LfjHxtnko8y/wA7iz68RjISb93/GudT6vEeSj7PreczF8AQF
         y67jk9e6D3SbqgvmblqPlbc/hSthX/Gs8xe6Uuew6OXPdlBWOcIejZVOIDyXHQnUfxSa
         sHQg==
X-Gm-Message-State: AGi0PubAjkP/LI2YegyaKPaShPs4V8jQJTw6iC6NKARe6CLVLHRQRYf2
        awNRBtSxg/3LSEddwhmx1WrfbmA0AYBnXbRS0gOy8lmPHCceGQ==
X-Google-Smtp-Source: APiQypKiW+5K0iIExgtZmen2x20OqxZ63I0VRkzalxonLHEZYX6mBfSp24X+mssKwRT5Rz35YF2TSuEg/IGVr/32UbA=
X-Received: by 2002:a05:6102:a01:: with SMTP id t1mr2866733vsa.108.1586928282467;
 Tue, 14 Apr 2020 22:24:42 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Gottula <justin@jgottula.com>
Date:   Tue, 14 Apr 2020 22:24:18 -0700
Message-ID: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
Subject: [PATCH] zram: fix writeback_store returning zero in most situations
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3b82a051c101 ("zram: fix error return codes not being returned in
writeback_store") altered the return value logic in writeback_store such
that ret = len is done at the beginning of the function, which alleviated
an issue where the -EIO and -ENOSPC break-outs from the for-loop would
unintentionally hit the ret = len previously located at the end of the
function. That change in itself was largely fine; however, it exposed
another return value logic problem.

Currently, when the writeback_store for-loop does _not_ encounter the -EIO
or -ENOSPC situations, and _does_ attempt to write at least one block to
the backing device, the function will simply return whatever the most
recent submit_bio_wait return value was. This means that if at least one
block write is attempted, the function will never actually return len; and,
if the last written block's call to submit_bio_wait was successful, then
the function will actually return _zero_. (Prior to the above-mentioned
patch, this situation was masked by the fact that the ret = len assignment
occurred _after_ all calls to submit_bio_wait.)

So, if writeback of one or more blocks is attempted, and the last
submit_bio_wait is successful (which will usually be the case), userspace
programs performing write(3) syscalls to /sys/block/zramN/writeback will
receive a return value of zero. Well-written programs use non-negative
return values from write(3) to determine if a partial write occurred, and
in that circumstance, they generally add the value to their buffer pointer
and call write(3) again. Programs written this way will, as a result,
effectively spin in a loop calling write(3) forever (or at least until an
actual error value does finally crop up), repeatedly writing the entire
string buffer ("huge" or "idle") to the writeback file and getting the
false impression that no forward progress is being made, since zero bytes
of the buffer are apparently being consumed with each syscall.

I came across this problem while adding a new parameter to the zramctl
program, in a personal fork of the util-linux suite, that would allow the
user to easily request writeback on a zram device. In zramctl (and the
util-linux programs in general), sysfs writes are typically done via
ul_path_write_string, which invokes write_all. The write_all utility
function is written in such a way that write(3) return values _not greater
than zero_ are treated as error conditions; upon which, any errno value
other than EINTR or EAGAIN will cause the function to bail out and indicate
an error. A return value of zero is indeed greater than zero; and an errno
value of zero is neither EINTR nor EAGAIN; so write_all bails and indicates
an error. (And thanks to automatic strerror-based printout functions, this
of course produces the message "error: Success", a personal favorite of
mine.)

The writeback_store return value problem is addressed by storing the
submit_bio_wait result in a separate local variable, which is only assigned
to ret if it is actually an errno value.

The behavior should now be that, if an error arises from one or more of the
calls to submit_bio_wait during writeback_store, and none of the other
explicit error cases in the function are triggered, then the most recent
submit_bio_wait error will be returned. Otherwise, the function will return
len.

Fixes: a939888ec38b ("zram: support idle/huge page writeback")
Signed-off-by: Justin Gottula <justin@jgottula.com>
---
Side Note: My understanding of whether a return value of zero from
write(3) is actually even valid--given a nonzero length parameter--became a
whole lot murkier when I took a really close look at the Linux and POSIX
man pages, as well as Internet discussions on the topic. Initially I was
sure that a zero return value indicated that no error had occurred, but
that no forward progress on the write had been made either; and that as
such, the implementation of write_all in util-linux was faulty. But now
I've come to understand that apparently some historical implementations of
write(3) have actually returned zero as an indication that a non-blocking
write on certain special files would block (though modern POSIX specifies
returning -1 and setting errno to EAGAIN for this case); and that a return
value of zero may apparently be used as an EOF indication. So perhaps
treating a zero result as an error in write_all, implicit and accidental
though it may have appeared, was actually intentional and well-founded all
along; I don't entirely know. In any case, though, it's clear that the zram
driver shouldn't be returning 0 in this circumstance.

 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bf4a908a0bd..e55330a615c2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -627,6 +627,7 @@ static ssize_t writeback_store(struct device *dev,
    struct bio_vec bio_vec;
    struct page *page;
    ssize_t ret = len;
+   int bio_ret;
    int mode;
    unsigned long blk_idx = 0;

@@ -719,8 +720,9 @@ static ssize_t writeback_store(struct device *dev,
         * XXX: A single page IO would be inefficient for write
         * but it would be not bad as starter.
         */
-       ret = submit_bio_wait(&bio);
-       if (ret) {
+       bio_ret = submit_bio_wait(&bio);
+       if (bio_ret) {
+           ret = bio_ret;
            zram_slot_lock(zram, index);
            zram_clear_flag(zram, index, ZRAM_UNDER_WB);
            zram_clear_flag(zram, index, ZRAM_IDLE);
--
2.25.1
