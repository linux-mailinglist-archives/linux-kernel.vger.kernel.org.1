Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B522767A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIXEVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXEVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:21:13 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69781C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:21:13 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id d2so553659vkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=be9SxU+lEQHtdVjUcSb4Re6tmWTa2P03Tfv82Pd6YRI=;
        b=HQ56dQFl0J10MUP/q4igvoiFc+X+jkjdPn7AuEWGVqwXcyMibj8cjfqLb3vkZ5/bew
         /DV4zJO4lRNVB5pm/64GEqYAe2hFn6zGBj680glxPTkjfvOwIoYz/FmlYeDPKYSs7Usy
         eP5YzolqU3tDlUN475GKNMpgJys7D7wMThn7G0uquSjsNolk4enzhqcD0+7PSl1k6D1h
         m8ctPrGTkSU0lvzSfIQFlQfBIdqVU+Aalr9GYiSy+EQ9IgtB3vshBU3S+dGn18Y0U2Hz
         KraNXy8w1640PDola9AMDrJ46AbzUYp+r2fHtI8mZGvQxndxnsT+2VASqrb4BCmz9/5o
         GBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=be9SxU+lEQHtdVjUcSb4Re6tmWTa2P03Tfv82Pd6YRI=;
        b=MxwRMjbwzDzXnW/jdlMuQQMTcn9qfE19SSeymTJG9o7ZmtUqWRlQ+cja/m19IIaawY
         F5HvStpKdRBWirxGnKKRU2G9cgFoXjDY2CrIq/90LoS05a/ebHW79w/fPNSPhUMASoP/
         WFtj12GKjEsyNOQN3z5nrSZh47Se/ThXucTSrI4tZHcXuB3VGQMP0HTZvCa3MfegobCe
         Y+2D+pB1rm8slzUSfVqntbQfDdrfKt0Sp7RQwM+ROkEYdp6HN9+XLLrfiff8buGGvMS3
         2U26MDUDLH9q1Q75gbif1HsJvPfQWd6H2/bAz3TCbRbOGvCfeqdpS4PLEIQDU4FObZ58
         pBfg==
X-Gm-Message-State: AOAM530GZyrXMe1qgBMuRdFAKhUoAH875YlTp00EmOpo7sIQqAMkkwcJ
        XjE53Qm0DBkrrb/FFVh/Q4I4p4H84qVKmbxi2kxoZMTedSgHU64S
X-Google-Smtp-Source: ABdhPJzlrw02huZ9uJqRDgWZYlkzeSPhelNKiKRar5Jxxrv5fhyWb7cEcPmIZOBp26E+RkYp+V8XIop5M0AO9EFxT6E=
X-Received: by 2002:ac5:ccd3:: with SMTP id j19mr2638724vkn.8.1600921270359;
 Wed, 23 Sep 2020 21:21:10 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Sep 2020 09:50:59 +0530
Message-ID: <CA+G9fYv0+NPwkT0r-T_nk5T0UE-GAbN_8Fh3VSLW8P+Prsv_4g@mail.gmail.com>
Subject: ARC: allmodconfig: Error: inappropriate arguments for opcode 'mpyd'
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Cc:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        lkft-triage@lists.linaro.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Guenter Roeck <linux@roeck-us.net>, vgupta@synopsys.com,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arc:allmodconfig build failed with gcc-8, gcc-9 and gcc-10 on Linus's
mainline tree.

Build log:
------------
make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux ARCH=3Darc
CROSS_COMPILE=3Darc-elf32- HOSTCC=3Dgcc CC=3D"sccache arc-elf32-gcc" O=3Dbu=
ild
allmodconfig

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darc
CROSS_COMPILE=3Darc-elf32- HOSTCC=3Dgcc CC=3D"sccache arc-elf32-gcc" O=3Dbu=
ild
uImage

In file included from <command-line>:31:
./usr/include/sound/hdspm.h:48:2: error: unknown type name =E2=80=98__u32=
=E2=80=99
  __u32 input_peaks[64];
  ^~~~~
./usr/include/sound/hdspm.h:49:2: error: unknown type name =E2=80=98__u32=
=E2=80=99
  __u32 playback_peaks[64];
  ^~~~~
./usr/include/sound/hdspm.h:50:2: error: unknown type name =E2=80=98__u32=
=E2=80=99
  __u32 output_peaks[64];
  ^~~~~
./usr/include/sound/hdspm.h:52:2: error: unknown type name =E2=80=98__u64=
=E2=80=99
  __u64 input_rms[64];
  ^~~~~
./usr/include/sound/hdspm.h:53:2: error: unknown type name =E2=80=98__u64=
=E2=80=99
  __u64 playback_rms[64];
  ^~~~~
./usr/include/sound/hdspm.h:54:2: error: unknown type name =E2=80=98__u64=
=E2=80=99
  __u64 output_rms[64];
  ^~~~~
./usr/include/sound/hdspm.h:56:2: error: unknown type name =E2=80=98__u8=E2=
=80=99
  __u8 speed; /* enum {ss, ds, qs} */
  ^~~~
./usr/include/sound/hdspm.h:157:2: error: unknown type name =E2=80=98__u8=
=E2=80=99
  __u8 card_type; /* enum hdspm_io_type */
  ^~~~
./usr/include/sound/hdspm.h:160:2: error: unknown type name =E2=80=98__u64=
=E2=80=99
  __u64 card_clock;
  ^~~~~
./usr/include/sound/hdspm.h:161:2: error: unknown type name =E2=80=98__u32=
=E2=80=99
  __u32 master_period;
  ^~~~~
./usr/include/sound/hdspm.h:165:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 sync_wc; /* enum hdspm_sync */
    ^~~~
./usr/include/sound/hdspm.h:166:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 sync_madi; /* enum hdspm_sync */
    ^~~~
./usr/include/sound/hdspm.h:167:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 sync_tco; /* enum hdspm_sync */
    ^~~~
./usr/include/sound/hdspm.h:168:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 sync_in; /* enum hdspm_sync */
    ^~~~
./usr/include/sound/hdspm.h:169:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 madi_input; /* enum hdspm_madi_input */
    ^~~~
./usr/include/sound/hdspm.h:170:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 channel_format; /* enum hdspm_madi_channel_format */
    ^~~~
./usr/include/sound/hdspm.h:171:4: error: unknown type name =E2=80=98__u8=
=E2=80=99
    __u8 frame_format; /* enum hdspm_madi_frame_format */
    ^~~~
./usr/include/sound/hdspm.h:186:2: error: unknown type name =E2=80=98__u8=
=E2=80=99
  __u8 card_type; /* enum hdspm_io_type */
  ^~~~
make[3]: *** [../usr/include/Makefile:108:
usr/include/sound/hdspm.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/sound/hdsp.h:39:2: error: unknown type name =E2=80=98__u32=E2=
=80=99
  __u32 input_peaks[26];
  ^~~~~
./usr/include/sound/hdsp.h:40:2: error: unknown type name =E2=80=98__u32=E2=
=80=99
  __u32 playback_peaks[26];
  ^~~~~
./usr/include/sound/hdsp.h:41:2: error: unknown type name =E2=80=98__u32=E2=
=80=99
  __u32 output_peaks[28];
  ^~~~~
./usr/include/sound/hdsp.h:42:2: error: unknown type name =E2=80=98__u64=E2=
=80=99
  __u64 input_rms[26];
  ^~~~~
./usr/include/sound/hdsp.h:43:2: error: unknown type name =E2=80=98__u64=E2=
=80=99
  __u64 playback_rms[26];
  ^~~~~
./usr/include/sound/hdsp.h:45:2: error: unknown type name =E2=80=98__u64=E2=
=80=99
  __u64 output_rms[26];
  ^~~~~
make[3]: *** [../usr/include/Makefile:108:
usr/include/sound/hdsp.hdrtest] Error 1
{standard input}: Assembler messages:
{standard input}:9360: Error: inappropriate arguments for opcode 'mpyd'
make[3]: *** [../scripts/Makefile.build:283: kernel/sched/core.o] Error 1
../arch/arc/kernel/kgdb.c: In function =E2=80=98kgdb_arch_handle_exception=
=E2=80=99:
../arch/arc/kernel/kgdb.c:141:6: warning: this statement may fall
through [-Wimplicit-fallthrough=3D]
   if (kgdb_hex2long(&ptr, &addr))
      ^
../arch/arc/kernel/kgdb.c:144:2: note: here
  case 'D':
  ^~~~
In file included from ./usr/include/linux/netfilter_ipv6/ip6_tables.h:21,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter_ipv6/ip6_tables.hdrtest] Error 1
../arch/arc/kernel/perf_event.c: In function =E2=80=98arc_pmu_device_probe=
=E2=80=99:
../arch/arc/kernel/perf_event.c:645:3: warning: ignoring return value
of =E2=80=98request_percpu_irq=E2=80=99, declared with attribute warn_unuse=
d_result
[-Wunused-result]
   request_percpu_irq(irq, arc_pmu_intr, "ARC perf counters",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        this_cpu_ptr(&arc_pmu_cpu));
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./usr/include/linux/if_bonding.h:47,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/if_bonding.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter_ipv4/ip_tables.h:21,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter_ipv4/ip_tables.hdrtest] Error 1
In file included from ./usr/include/linux/ip6_tunnel.h:6,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/ip6_tunnel.hdrtest] Error 1
In file included from ./usr/include/linux/if_pppox.h:25,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/if_pppox.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/linux/tipc_config.h:46:10: fatal error: arpa/inet.h: No
such file or directory
 #include <arpa/inet.h> /* for ntohs etc. */
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/tipc_config.hdrtest] Error 1
In file included from ./usr/include/linux/bpfilter.h:5,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/bpfilter.hdrtest] Error 1
In file included from ./usr/include/linux/if_tunnel.h:6,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/if_tunnel.hdrtest] Error 1
../drivers/irqchip/irq-tb10x.c: In function =E2=80=98tb10x_irq_set_type=E2=
=80=99:
../drivers/irqchip/irq-tb10x.c:62:13: warning: this statement may fall
through [-Wimplicit-fallthrough=3D]
   flow_type =3D IRQ_TYPE_LEVEL_LOW;
   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
../drivers/irqchip/irq-tb10x.c:63:2: note: here
  case IRQ_TYPE_LEVEL_LOW:
  ^~~~
In file included from <command-line>:31:
./usr/include/linux/lightnvm.h:24:10: fatal error: sys/ioctl.h: No
such file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/lightnvm.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/linux/auto_fs.h:18:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/auto_fs.hdrtest] Error 1
In file included from ./usr/include/linux/uhid.h:23,
                 from <command-line>:31:
./usr/include/linux/input.h:14:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/uhid.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108: usr/include/linux/if.hdrtest] Er=
ror 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: kernel/sched] Error 2
../samples/auxdisplay/cfag12864b-example.c:22:10: fatal error:
sys/mman.h: No such file or directory
 #include <sys/mman.h>
          ^~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28:
samples/auxdisplay/cfag12864b-example] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/auxdisplay] Error 2
../samples/binderfs/binderfs_example.c:10:10: fatal error:
sys/ioctl.h: No such file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28:
samples/binderfs/binderfs_example] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/binderfs] Error 2
../samples/connector/ucon.c:11:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28: samples/connector/ucon] Error =
1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/connector] Error 2
In file included from ../samples/hidraw/hid-example.c:15:
usr/include/linux/input.h:14:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28: samples/hidraw/hid-example] Er=
ror 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/hidraw] Error 2
../samples/timers/hpet_example.c:25:10: fatal error: sys/poll.h: No
such file or directory
 #include <sys/poll.h>
          ^~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28:
samples/timers/hpet_example] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/timers] Error 2
In file included from ./usr/include/linux/if_pppox.h:25,
                 from ./usr/include/linux/netfilter_bridge.h:12,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter_bridge.hdrtest] Error 1
../samples/uhid/uhid-example.c:42:10: fatal error: poll.h: No such
file or directory
 #include <poll.h>
          ^~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28: samples/uhid/uhid-example] Err=
or 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/uhid] Error 2
../samples/vfs/test-fsmount.c:13:10: fatal error: sys/prctl.h: No such
file or directory
 #include <sys/prctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28: samples/vfs/test-fsmount] Erro=
r 1
../samples/vfs/test-statx.c:20:10: fatal error: sys/syscall.h: No such
file or directory
 #include <sys/syscall.h>
          ^~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28: samples/vfs/test-statx] Error =
1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/vfs] Error 2
../samples/watch_queue/watch_test.c:17:10: fatal error: sys/ioctl.h:
No such file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:28:
samples/watch_queue/watch_test] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/watch_queue] Error 2
/usr/bin/../lib/gcc/arc-elf32/8.3.1/../../../../arc-elf32/bin/ld:
/tmp/ccYOsOrv.o: in function `main':
watchdog-simple.c:(.text.startup+0x26): undefined reference to `sleep'
/usr/bin/../lib/gcc/arc-elf32/8.3.1/../../../../arc-elf32/bin/ld:
watchdog-simple.c:(.text.startup+0x26): undefined reference to `sleep'
collect2: error: ld returned 1 exit status
make[3]: *** [scripts/Makefile.userprogs:28:
samples/watchdog/watchdog-simple] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: samples/watchdog] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1784: samples] Error 2
In file included from ./usr/include/linux/llc.h:18,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/llc.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter_bridge/ebtables.h:17,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter_bridge/ebtables.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter_arp/arp_tables.h:15,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter_arp/arp_tables.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter_arp/arp_tables.h:15,
                 from ./usr/include/linux/netfilter_arp/arpt_mangle.h:4,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter_arp/arpt_mangle.hdrtest] Error 1
In file included from ./usr/include/linux/if_frad.h:28,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/if_frad.hdrtest] Error 1
In file included from ./usr/include/linux/wireless.h:75,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/wireless.hdrtest] Error 1
In file included from ./usr/include/linux/netdevice.h:29,
                 from ./usr/include/linux/if_arp.h:27,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/if_arp.hdrtest] Error 1
In file included from ./usr/include/linux/gsmmux.h:5,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/gsmmux.hdrtest] Error 1
In file included from ../arch/arc/include/asm/atomic.h:13,
                 from ../include/linux/atomic.h:7,
                 from ../include/linux/page_counter.h:5,
                 from ../mm/memcontrol.c:25:
../mm/memcontrol.c: In function =E2=80=98memcg_reparent_objcgs=E2=80=99:
../arch/arc/include/asm/cmpxchg.h:134:27: warning: value computed is
not used [-Wunused-value]
 #define _xchg(ptr, with) ((typeof(*(ptr)))__xchg((unsigned
long)(with), (ptr), \

~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        sizeof(*(ptr))))
        ~~~~~~~~~~~~~~~~
../arch/arc/include/asm/cmpxchg.h:167:26: note: in expansion of macro =E2=
=80=98_xchg=E2=80=99
 #define xchg(ptr, with)  _xchg(ptr, with)
                          ^~~~~
../mm/memcontrol.c:333:2: note: in expansion of macro =E2=80=98xchg=E2=80=
=99
  xchg(&objcg->memcg, parent);
  ^~~~
../arch/arc/include/asm/cmpxchg.h:134:27: warning: value computed is
not used [-Wunused-value]
 #define _xchg(ptr, with) ((typeof(*(ptr)))__xchg((unsigned
long)(with), (ptr), \

~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        sizeof(*(ptr))))
        ~~~~~~~~~~~~~~~~
../arch/arc/include/asm/cmpxchg.h:167:26: note: in expansion of macro =E2=
=80=98_xchg=E2=80=99
 #define xchg(ptr, with)  _xchg(ptr, with)
                          ^~~~~
../mm/memcontrol.c:340:3: note: in expansion of macro =E2=80=98xchg=E2=80=
=99
   xchg(&iter->memcg, parent);
   ^~~~
In file included from ./usr/include/linux/uinput.h:44,
                 from <command-line>:31:
./usr/include/linux/input.h:14:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/uinput.hdrtest] Error 1
In file included from ./usr/include/linux/auto_fs4.h:13,
                 from <command-line>:31:
./usr/include/linux/auto_fs.h:18:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/auto_fs4.hdrtest] Error 1
In file included from ./usr/include/linux/route.h:27,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/route.hdrtest] Error 1
In file included from ./usr/include/linux/netdevice.h:29,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netdevice.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/linux/soundcard.h:43:12: fatal error: endian.h: No such
file or directory
 #  include <endian.h>
            ^~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/soundcard.hdrtest] Error 1
In file included from ./usr/include/linux/atmbr2684.h:7,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/atmbr2684.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/linux/input.h:14:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/input.hdrtest] Error 1
In file included from ./usr/include/linux/kfd_ioctl.h:26,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/kfd_ioctl.hdrtest] Error 1
In file included from ./usr/include/linux/auto_dev-ioctl.h:14,
                 from <command-line>:31:
./usr/include/linux/auto_fs.h:18:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/auto_dev-ioctl.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter/xt_physdev.h:6,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter/xt_physdev.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter/xt_hashlimit.h:7,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter/xt_hashlimit.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter/xt_RATEEST.h:6,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter/xt_RATEEST.hdrtest] Error 1
In file included from ./usr/include/linux/netfilter/xt_rateest.h:6,
                 from <command-line>:31:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/netfilter/xt_rateest.hdrtest] Error 1
In file included from ./usr/include/linux/joystick.h:28,
                 from <command-line>:31:
./usr/include/linux/input.h:14:10: fatal error: sys/ioctl.h: No such
file or directory
 #include <sys/ioctl.h>
          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/linux/joystick.hdrtest] Error 1
In file included from ./usr/include/drm/drm_mode.h:30,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/drm_mode.hdrtest] Error 1
In file included from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108: usr/include/drm/drm.hdrtest] Err=
or 1
In file included from ./usr/include/drm/i810_drm.h:5,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/i810_drm.hdrtest] Error 1
In file included from ./usr/include/drm/panfrost_drm.h:9,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/panfrost_drm.hdrtest] Error 1
In file included from ./usr/include/drm/drm_fourcc.h:27,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/drm_fourcc.hdrtest] Error 1
In file included from ./usr/include/drm/virtgpu_drm.h:27,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/virtgpu_drm.hdrtest] Error 1
In file included from ./usr/include/drm/radeon_drm.h:36,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/radeon_drm.hdrtest] Error 1
In file included from ./usr/include/drm/sis_drm.h:30,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/sis_drm.hdrtest] Error 1
In file included from ./usr/include/drm/tegra_drm.h:26,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/tegra_drm.hdrtest] Error 1
In file included from ./usr/include/drm/lima_drm.h:7,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/lima_drm.hdrtest] Error 1
In file included from ./usr/include/drm/omap_drm.h:24,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/omap_drm.hdrtest] Error 1
In file included from ./usr/include/drm/msm_drm.h:28,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/msm_drm.hdrtest] Error 1
In file included from ./usr/include/drm/savage_drm.h:29,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/savage_drm.hdrtest] Error 1
In file included from ./usr/include/drm/vgem_drm.h:30,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/vgem_drm.hdrtest] Error 1
In file included from ./usr/include/drm/amdgpu_drm.h:35,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/amdgpu_drm.hdrtest] Error 1
In file included from ./usr/include/drm/via_drm.h:27,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/via_drm.hdrtest] Error 1
In file included from ./usr/include/drm/qxl_drm.h:27,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/qxl_drm.hdrtest] Error 1
In file included from ./usr/include/drm/nouveau_drm.h:30,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/nouveau_drm.hdrtest] Error 1
In file included from ./usr/include/drm/mga_drm.h:38,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/mga_drm.hdrtest] Error 1
In file included from ./usr/include/drm/r128_drm.h:36,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/r128_drm.hdrtest] Error 1
In file included from ./usr/include/drm/vc4_drm.h:27,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/vc4_drm.hdrtest] Error 1
In file included from ./usr/include/drm/drm_sarea.h:35,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/drm_sarea.hdrtest] Error 1
In file included from ./usr/include/drm/exynos_drm.h:19,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/exynos_drm.hdrtest] Error 1
In file included from ./usr/include/drm/v3d_drm.h:27,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/v3d_drm.hdrtest] Error 1
In file included from ./usr/include/drm/armada_drm.h:13,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/armada_drm.hdrtest] Error 1
In file included from ./usr/include/drm/etnaviv_drm.h:21,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/etnaviv_drm.hdrtest] Error 1
In file included from ./usr/include/drm/i915_drm.h:30,
                 from <command-line>:31:
./usr/include/drm/drm.h:48:10: fatal error: sys/ioccom.h: No such file
or directory
 #include <sys/ioccom.h>
          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [../usr/include/Makefile:108:
usr/include/drm/i915_drm.hdrtest] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: usr/include] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1784: usr] Error 2
../fs/dax.c: In function =E2=80=98copy_cow_page_dax=E2=80=99:
../fs/dax.c:702:2: error: implicit declaration of function
=E2=80=98copy_user_page=E2=80=99; did you mean =E2=80=98copy_to_user_page=
=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  copy_user_page(vto, (void __force *)kaddr, vaddr, to);
  ^~~~~~~~~~~~~~
  copy_to_user_page
cc1: some warnings being treated as errors
make[2]: *** [../scripts/Makefile.build:283: fs/dax.o] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1784: fs] Error 2
In file included from ../include/linux/atomic.h:84,
                 from ../drivers/iommu/io-pgtable-arm.c:12:
../drivers/iommu/io-pgtable-arm.c: In function =E2=80=98arm_lpae_install_ta=
ble=E2=80=99:
../include/linux/atomic-fallback.h:58:28: error: implicit declaration
of function =E2=80=98cmpxchg64=E2=80=99; did you mean =E2=80=98cmpxchg=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
 #define cmpxchg64_relaxed  cmpxchg64
                            ^~~~~~~~~
../drivers/iommu/io-pgtable-arm.c:343:8: note: in expansion of macro
=E2=80=98cmpxchg64_relaxed=E2=80=99
  old =3D cmpxchg64_relaxed(ptep, curr, new);
        ^~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [../scripts/Makefile.build:283:
drivers/iommu/io-pgtable-arm.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: drivers/iommu] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1784: kernel] Error 2
../drivers/clocksource/mps2-timer.c:25: warning: "TIMER_CTRL_IE" redefined
 #define TIMER_CTRL_IE  BIT(3)

In file included from ../arch/arc/include/asm/arcregs.h:253,
                 from ../arch/arc/include/asm/irqflags-arcv2.h:9,
                 from ../arch/arc/include/asm/irqflags.h:13,
                 from ../include/linux/irqflags.h:16,
                 from ../include/linux/spinlock.h:54,
                 from ../include/linux/rwsem.h:16,
                 from ../include/linux/notifier.h:15,
                 from ../include/linux/clk.h:14,
                 from ../drivers/clocksource/mps2-timer.c:10:
../include/soc/arc/timers.h:20: note: this is the location of the
previous definition
 #define TIMER_CTRL_IE         (1 << 0) /* Interrupt when Count reaches lim=
it */

In file included from ../drivers/clocksource/timer-sp804.c:23:
../drivers/clocksource/timer-sp.h:24: warning: "TIMER_CTRL_IE" redefined
 #define TIMER_CTRL_IE  (1 << 5) /*   VR */

In file included from ../arch/arc/include/asm/arcregs.h:253,
                 from ../arch/arc/include/asm/irqflags-arcv2.h:9,
                 from ../arch/arc/include/asm/irqflags.h:13,
                 from ../include/linux/irqflags.h:16,
                 from ../include/linux/spinlock.h:54,
                 from ../include/linux/rwsem.h:16,
                 from ../include/linux/notifier.h:15,
                 from ../include/linux/clk.h:14,
                 from ../drivers/clocksource/timer-sp804.c:8:
../include/soc/arc/timers.h:20: note: this is the location of the
previous definition
 #define TIMER_CTRL_IE         (1 << 0) /* Interrupt when Count reaches lim=
it */

In file included from ../drivers/clocksource/timer-integrator-ap.c:17:
../drivers/clocksource/timer-sp.h:24: warning: "TIMER_CTRL_IE" redefined
 #define TIMER_CTRL_IE  (1 << 5) /*   VR */

In file included from ../arch/arc/include/asm/arcregs.h:253,
                 from ../arch/arc/include/asm/irqflags-arcv2.h:9,
                 from ../arch/arc/include/asm/irqflags.h:13,
                 from ../include/linux/irqflags.h:16,
                 from ../include/linux/spinlock.h:54,
                 from ../include/linux/rwsem.h:16,
                 from ../include/linux/notifier.h:15,
                 from ../include/linux/clk.h:14,
                 from ../drivers/clocksource/timer-integrator-ap.c:8:
../include/soc/arc/timers.h:20: note: this is the location of the
previous definition
 #define TIMER_CTRL_IE         (1 << 0) /* Interrupt when Count reaches lim=
it */

make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1784: drivers] Error 2
make[1]: Target 'uImage' not remade because of errors.
make: *** [Makefile:185: __sub-make] Error 2
make: Target 'uImage' not remade because of errors.

ref:
https://builds.tuxbuild.com/UgyvpXGPcSWBknR6SRnjkA/

--=20
Linaro LKFT
https://lkft.linaro.org
