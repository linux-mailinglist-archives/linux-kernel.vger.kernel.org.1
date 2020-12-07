Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CDB2D1730
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgLGRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:10:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2215 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:10:06 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqV8j5gV7z67MQF;
        Tue,  8 Dec 2020 01:06:45 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 7 Dec 2020 18:09:18 +0100
Received: from [10.47.199.254] (10.47.199.254) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 17:09:12 +0000
Subject: Re: [PATCH 3/3] perf tools: Allow to list events via control file
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-4-jolsa@kernel.org>
 <20201207162806.GE125383@kernel.org>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <ebfd55bc-9118-920e-3ffd-0c24833c08b9@huawei.com>
Date:   Mon, 7 Dec 2020 20:09:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201207162806.GE125383@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.199.254]
X-ClientProxiedBy: braeml704-chm.china.huawei.com (10.226.71.60) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.12.2020 19:28, Arnaldo Carvalho de Melo wrote:
> Em Sun, Dec 06, 2020 at 06:05:19PM +0100, Jiri Olsa escreveu:
>> Adding new control event to display all evlist events.
>>
>> The interface string for control file is 'list'. When
>> received, perf will scan and print current evlist into
>> perf record terminal.
>>
>> Example session:
>>
>>   terminal 1:
>>     # mkfifo control ack perf.pipe
>>     # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
>>     Events disabled
>>
>>   terminal 2:
>>     # echo list > control
>>
>>   terminal 1:
>>     # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
>>     ...
>>     sched:sched_kthread_stop
>>     sched:sched_kthread_stop_ret
>>     sched:sched_waking
>>     sched:sched_wakeup
>>     sched:sched_wakeup_new
>>     sched:sched_switch
>>     sched:sched_migrate_task
>>     sched:sched_process_free
>>     sched:sched_process_exit
>>     sched:sched_wait_task
>>     sched:sched_process_wait
>>     sched:sched_process_fork
>>     sched:sched_process_exec
>>     sched:sched_stat_wait
>>     sched:sched_stat_sleep
>>     sched:sched_stat_iowait
>>     sched:sched_stat_blocked
>>     sched:sched_stat_runtime
>>     sched:sched_pi_setprio
>>     sched:sched_move_numa
>>     sched:sched_stick_numa
>>     sched:sched_swap_numa
>>     sched:sched_wake_idle_without_ipi
>>     dummy:HG
>>
>> This new command is handy to get real event names when
>> wildcards are used.
> 
> Ok, would be nice to have a verbose mode like:
> 
> [acme@five ~]$ sudo ~acme/bin/perf record -e 'sched:*' sleep 0.001
> [ perf record: Woken up 14 times to write data ]
> [ perf record: Captured and wrote 0.023 MB perf.data (16 samples) ]
> [acme@five ~]$ sudo ~acme/bin/perf evlist
> sched:sched_kthread_stop
> sched:sched_kthread_stop_ret
> sched:sched_waking
> sched:sched_wakeup
> sched:sched_wakeup_new
> sched:sched_switch
> sched:sched_migrate_task
> sched:sched_process_free
> sched:sched_process_exit
> sched:sched_wait_task
> sched:sched_process_wait
> sched:sched_process_fork
> sched:sched_process_exec
> sched:sched_stat_wait
> sched:sched_stat_sleep
> sched:sched_stat_iowait
> sched:sched_stat_blocked
> sched:sched_stat_runtime
> sched:sched_pi_setprio
> sched:sched_move_numa
> sched:sched_stick_numa
> sched:sched_swap_numa
> sched:sched_wake_idle_without_ipi
> # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> [acme@five ~]$ sudo ~acme/bin/perf evlist -v
> sched:sched_kthread_stop: type: 2, size: 120, config: 0x13f, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> sched:sched_kthread_stop_ret: type: 2, size: 120, config: 0x13e, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_waking: type: 2, size: 120, config: 0x13d, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_wakeup: type: 2, size: 120, config: 0x13c, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_wakeup_new: type: 2, size: 120, config: 0x13b, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_switch: type: 2, size: 120, config: 0x13a, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_migrate_task: type: 2, size: 120, config: 0x139, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_process_free: type: 2, size: 120, config: 0x138, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_process_exit: type: 2, size: 120, config: 0x137, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_wait_task: type: 2, size: 120, config: 0x136, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_process_wait: type: 2, size: 120, config: 0x135, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_process_fork: type: 2, size: 120, config: 0x134, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_process_exec: type: 2, size: 120, config: 0x133, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_stat_wait: type: 2, size: 120, config: 0x132, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_stat_sleep: type: 2, size: 120, config: 0x131, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_stat_iowait: type: 2, size: 120, config: 0x130, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_stat_blocked: type: 2, size: 120, config: 0x12f, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_stat_runtime: type: 2, size: 120, config: 0x12e, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_pi_setprio: type: 2, size: 120, config: 0x12d, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_move_numa: type: 2, size: 120, config: 0x12c, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_stick_numa: type: 2, size: 120, config: 0x12b, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_swap_numa: type: 2, size: 120, config: 0x12a, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> sched:sched_wake_idle_without_ipi: type: 2, size: 120, config: 0x129, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> [acme@five ~]$
> 
> Also I think we should use 'evlist' instead of 'list', to be consistent.

FWIW,

Or may be even name the command starting with a verb like 'list_events'

Thanks,
Alexei

> 
> Applied 1/3 and 2/3.
> 
> - Arnaldo
>  
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>  tools/perf/builtin-record.c | 1 +
>>  tools/perf/builtin-stat.c   | 1 +
>>  tools/perf/util/evlist.c    | 6 ++++++
>>  tools/perf/util/evlist.h    | 2 ++
>>  4 files changed, 10 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 582b8fba012c..f620ed056c89 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1951,6 +1951,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  			case EVLIST_CTL_CMD_UNSUPPORTED:
>>  			case EVLIST_CTL_CMD_ENABLE_EVSEL:
>>  			case EVLIST_CTL_CMD_DISABLE_EVSEL:
>> +			case EVLIST_CTL_CMD_LIST:
>>  			default:
>>  				break;
>>  			}
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 6a21fb665008..56f2206b5991 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -592,6 +592,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>>  		case EVLIST_CTL_CMD_UNSUPPORTED:
>>  		case EVLIST_CTL_CMD_ENABLE_EVSEL:
>>  		case EVLIST_CTL_CMD_DISABLE_EVSEL:
>> +		case EVLIST_CTL_CMD_LIST:
>>  		default:
>>  			break;
>>  		}
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 05723227bebf..c05476ca2ff4 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1931,6 +1931,9 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>>  				    (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
>>  			*cmd = EVLIST_CTL_CMD_SNAPSHOT;
>>  			pr_debug("is snapshot\n");
>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_LIST_TAG,
>> +				    (sizeof(EVLIST_CTL_CMD_LIST_TAG)-1))) {
>> +			*cmd = EVLIST_CTL_CMD_LIST;
>>  		}
>>  	}
>>  
>> @@ -1995,6 +1998,9 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>>  					pr_info("failed: can't find %s event\n", evsel_name);
>>  				}
>>  				break;
>> +			case EVLIST_CTL_CMD_LIST:
>> +				evlist__for_each_entry(evlist, evsel)
>> +					pr_info("%s\n", evsel__name(evsel));
>>  			case EVLIST_CTL_CMD_SNAPSHOT:
>>  				break;
>>  			case EVLIST_CTL_CMD_ACK:
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index e4e8ff8831a3..6b8a9918fdb2 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -332,6 +332,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
>>  #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
>>  #define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
>>  #define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
>> +#define EVLIST_CTL_CMD_LIST_TAG "list"
>>  
>>  #define EVLIST_CTL_CMD_MAX_LEN 64
>>  
>> @@ -343,6 +344,7 @@ enum evlist_ctl_cmd {
>>  	EVLIST_CTL_CMD_DISABLE_EVSEL,
>>  	EVLIST_CTL_CMD_ACK,
>>  	EVLIST_CTL_CMD_SNAPSHOT,
>> +	EVLIST_CTL_CMD_LIST,
>>  };
>>  
>>  int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
>> -- 
>> 2.26.2
>>
> 
